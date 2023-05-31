#
# GNU Pronghorn, a fast and simple CI/CD pipeline.
# Copyright (C) 2022-2023 Wasym A. Alonso
#
# This work and all its documentation is licensed under the
# Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) License.
#
# You should have received a copy of the appropriate Creative Commons License
# along with this work. If not, see <https://creativecommons.org/licenses/by-sa/4.0/legalcode>.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/gpl-3.0>.
#


##################
# === MACROS === #
##################
# Project information
APP = pronghorn
DESC = A fast, simple, efficient and automated CI/CD pipeline
# Version and metadata
VERSION = 1
PATCHLEVEL = 0
SUBLEVEL = 0
EXTRAVERSION = -rc1
NAME = Hurr durr I'ma cute kitten
ifeq ($(SUBLEVEL),0)
	FULL_VERSION ?= $(VERSION).$(PATCHLEVEL)$(EXTRAVERSION)
else
	FULL_VERSION ?= $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
endif

# Dependencies
DEPS = pdfinfo gs tex texi2pdf makeinfo
DEPS_EXEC := $(foreach dep,$(DEPS),\
	$(if $(shell which $(dep) 2>/dev/null),,$(error No `$(dep)` in PATH)))

# Pretty Printing Output (PPO)
PPO_MKDIR = MKDIR
PPO_CLEAN = CLEAN
PPO_HTML = HTML
PPO_PDF = PDF
PPO_GS = GS
PPO_LN = LN

# Directories
DOCS_DIR = docs
BUILD_DIR = build

# Documentation
DOCS_BUILD_DIR := $(BUILD_DIR)/$(DOCS_DIR)
DOCS_ROOT_FILE := $(shell find $(DOCS_DIR) -type f -name "pronghorn.tex")
DOCS_SRC := $(shell find $(DOCS_DIR) -type f -iname "*.tex")
DOCS_METADATA_FILE := $(shell find $(DOCS_DIR) -type f -name "metadata.pdfmark")
DOCS_COVER_FILE := $(shell find $(DOCS_DIR) -type f -name "cover.ps")
DOCS_OUT_FILE := $(DOCS_BUILD_DIR)/$(APP).tmp.pdf
DOCS_PDF_FILE := $(APP)-v$(FULL_VERSION).pdf
DOCS_HTML_FILE := $(subst .pdf,.html,$(DOCS_PDF_FILE))
DOCS_CSS_FILE := $(shell find $(DOCS_DIR) -type f -name "style.css")
DOCS_PDF_NUM_PAGES = $(shell pdfinfo $(DOCS_PDF_FILE) | grep "Pages" | xargs | awk '{print $$2}')
DOCS_HTML_NUM_FILES = $(shell ls $(DOCS_HTML_FILE) | wc -l)

# PHONY targets definition
.PHONY: all pdf html clean mrproper help


###################
# === TARGETS === #
###################
# Root target
all: pdf html

# Documentation: PDF format
pdf: $(DOCS_PDF_FILE)
	@sleep 0.15
	@printf "Thesis: $^ is ready  (#$(DOCS_PDF_NUM_PAGES))\n"

# Documentation (PDF): Assembly of PDF file
$(DOCS_PDF_FILE): $(DOCS_METADATA_FILE) $(DOCS_COVER_FILE) $(DOCS_OUT_FILE)
	@printf "  $(PPO_GS)\t$@\n"
	@gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile=$@ $^

# Documentation (PDF): Building PDF file
$(DOCS_OUT_FILE): $(DOCS_SRC)
	@printf "  $(PPO_MKDIR)\t$(DOCS_BUILD_DIR)\n"
	@mkdir -p $(DOCS_BUILD_DIR)
	@for doc_src in $^ ; do                               \
		printf "  $(PPO_PDF)\t$${doc_src}\n" && sleep 0.25; \
	done
	@texi2pdf --build-dir=$(DOCS_BUILD_DIR) $(DOCS_ROOT_FILE) -o $(DOCS_OUT_FILE) &>/dev/null

# Documentation: HTML format
html: $(DOCS_HTML_FILE)
	@sleep 0.15
	@printf "Website: $^/index.html is ready  (#$(DOCS_HTML_NUM_FILES))\n"

# Documentation (HTML): Exporting HTML website
$(DOCS_HTML_FILE): $(DOCS_SRC) $(DOCS_CSS_FILE)
	@if [ -d $(DOCS_HTML_FILE) ]; then \
		rm -r $(DOCS_HTML_FILE);         \
	fi
	@printf "  $(PPO_MKDIR)\t$(DOCS_HTML_FILE)\n"
	@makeinfo --html $(DOCS_ROOT_FILE) --css-include $(DOCS_CSS_FILE) -o $(DOCS_HTML_FILE) &>/dev/null
	@for html_file in $$(ls $(DOCS_HTML_FILE)/*) ; do       \
		printf "  $(PPO_HTML)\t$${html_file}\n" && sleep 0.1; \
	done
	@printf "  $(PPO_LN)\t$(APP).html\n"
	@ln -s $@ $(APP).html


#########################
# === PHONY TARGETS === #
#########################
# Clean build directory
clean:
	@if [ -d $(BUILD_DIR) ]; then              \
		printf "  $(PPO_CLEAN)\t$(BUILD_DIR)\n"; \
		rm -r $(BUILD_DIR);                      \
	fi

# Cleans final products (depends on 'build')
mrproper: clean
	@if [ -e $(DOCS_PDF_FILE) ]; then              \
		printf "  $(PPO_CLEAN)\t$(DOCS_PDF_FILE)\n"; \
		rm $(DOCS_PDF_FILE);                         \
	fi
	@if [ -d $(DOCS_HTML_FILE) ]; then              \
		printf "  $(PPO_CLEAN)\t$(DOCS_HTML_FILE)\n"; \
		rm -r $(DOCS_HTML_FILE);                      \
		printf "  $(PPO_CLEAN)\t$(APP).html\n";       \
		rm $(APP).html;                               \
	fi

# Help
help:
	@printf "all\t\t- Build all targets marked with [*].\n"
	@printf "* pdf\t\t- Build the documentation in PDF format (formal thesis).\n"
	@printf "* html\t\t- Build the documentation in HTML format (text website).\n"
	@printf "clean\t\t- Clean build directory.\n"
	@printf "mrproper\t- Cleans final products (depends on 'build').\n"
	@echo
	@printf "Execute 'make' or 'make all' to build all targets marked with [*].\n"
	@printf "For further info see the ./README file and the documentation generated.\n"
