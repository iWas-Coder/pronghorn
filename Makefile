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

# Pretty Printing Output (PPO)
PPO_MKDIR = MKDIR
PPO_CLEAN = CLEAN
PPO_PDF = PDF
PPO_GS = GS

# Directories
DOCS_DIR = docs
BUILD_DIR = build

# Documentation
DOCS_BUILD_DIR := $(BUILD_DIR)/$(DOCS_DIR)
DOCS_ROOT_FILE := $(shell find $(DOCS_DIR) -type f -name "pronghorn.tex")
DOCS_SRC := $(shell find $(DOCS_DIR) -type f -iname "*.tex")
DOCS_COVER_FILE := $(shell find $(DOCS_DIR) -type f -name "cover.ps")
DOCS_OUT_FILE := $(DOCS_BUILD_DIR)/$(APP).pdf
DOCS_PDF_FILE := $(APP)-v$(FULL_VERSION).pdf
NUM_PAGES = $(shell pdfinfo $(DOCS_PDF) | grep "Pages" | xargs | awk '{print $2}')

# PHONY targets definition
.PHONY: all clean mrproper help


###################
# === TARGETS === #
###################
# Root target
all: $(DOCS_PDF_FILE)

# Documentation: Assembly of PDF file
$(DOCS_PDF_FILE): $(DOCS_COVER_FILE) $(DOCS_OUT_FILE)
	@printf "$(PPO_GS)\t$@\n"
	@gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile=$@ $^

# Documentation: Building PDF file
$(DOCS_OUT_FILE): $(DOCS_SRC)
	@printf "$(PPO_MKDIR)\t$(DOCS_BUILD_DIR)\n"
	@mkdir -p $(DOCS_BUILD_DIR)
	@for doc_src in $^ ; do \
		printf "$(PPO_PDF)\t$${doc_src}\n" && sleep 0.25; \
	done
	@texi2pdf --build-dir=$(DOCS_BUILD_DIR) $(DOCS_ROOT_FILE) -o $(DOCS_OUT_FILE) &>/dev/null


#########################
# === PHONY TARGETS === #
#########################
# Clean build directory
clean:
	@printf "$(PPO_CLEAN)\t$(BUILD_DIR)\n"
	@rm -rf $(BUILD_DIR)

# Cleans final products (depends on 'build')
mrproper: clean
	@printf "$(PPO_CLEAN)\t$(DOCS_PDF_FILE)\n"
	@rm -f $(DOCS_PDF_FILE)

# Help
help:
	@printf "all\t- Build all targets marked with [*]\n"
	@echo ""
	@printf "Execute 'make' or 'make all' to build all targets marked with [*]\n"
	@printf "For further info see the ./README file and the documentation generated\n"

