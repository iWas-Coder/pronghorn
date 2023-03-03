##################
# === MACROS === #
##################
# Version and metadata
VERSION = 1
PATCHLEVEL = 0
SUBLEVEL = 0
EXTRAVERSION = -rc1
NAME = pronghorn

# Pretty Printing Output (PPO)
PPO_MKDIR = MKDIR
PPO_PDF = PDF
PPO_GS = GS

# Documentation
DOCS_BUILD_DIR := build/docs
DOCS_ROOT := $(shell find docs -type f -name "pronghorn.tex")
DOCS_SRC := $(shell find docs -type f -iname "*.tex")
DOCS_COVER := $(shell find docs -type f -name "cover.ps")
DOCS_OUT := $(DOCS_BUILD_DIR)/$(NAME).pdf
DOCS_PDF := $(NAME)-v${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}.pdf
NUM_PAGES = $(shell pdfinfo $(DOCS_PDF) | grep "Pages" | xargs | awk '{print $2}')


###################
# === TARGETS === #
###################
# Documentation: Final PDF file
$(DOCS_PDF): $(DOCS_COVER) $(DOCS_OUT)
	@printf "$(PPO_GS)\t$^\n"
	@gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile=$@ $^

# Documentation: Documentation PDF Compilation
$(DOCS_OUT): $(DOCS_SRC)
	@printf "$(PPO_MKDIR)\t$(DOCS_BUILD_DIR)\n"
	@mkdir -p $(DOCS_BUILD_DIR)
	@for doc_src in $^ ; do \
		printf "$(PPO_PDF)\t\${doc_src}\n" && sleep 0.25; \
	done
	@texi2pdf --build-dir=$(DOCS_BUILD_DIR) $(DOCS_ROOT) -o $(DOCS_OUT) &>/dev/null
