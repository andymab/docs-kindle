.PHONY: help site epub kindle shell clean

# ================================
# Project settings
# ================================

DOCS_DIR := docs
EPUB_DIR := epub
SCRIPTS := scripts
SITE_CFG := site/mkdocs.yml

PANDOC_SERVICE := pandoc
DOCS_SERVICE := docs

.DEFAULT_GOAL := help

# ================================
# Helpers
# ================================

help:
	@echo ""
	@echo "Available commands:"
	@echo ""
	@echo "  make site                Run documentation site (MkDocs)"
	@echo "  make epub SRC=path       Build EPUB from md (index.md or file)"
	@echo "  make kindle FILE=epub    Send EPUB to Kindle"
	@echo "  make clean               Remove generated files"
	@echo "  make shell               Open shell in pandoc container"
	@echo ""

# ================================
# Site
# ================================

site:
	docker compose up $(DOCS_SERVICE)

# ================================
# EPUB
# ================================

epub:
ifndef SRC
	$(error Usage: make epub SRC=docs/docker/index.md)
endif
	mkdir -p $(EPUB_DIR)
	docker compose run --rm $(PANDOC_SERVICE) \
		$(SCRIPTS)/build-epub.sh $(SRC)

# ================================
# Kindle
# ================================

kindle:
ifndef FILE
	$(error Usage: make kindle FILE=epub/docker.epub)
endif
	docker compose run --rm $(PANDOC_SERVICE) \
		python scripts/send-to-kindle.py $(FILE)

# ================================
# Utils
# ================================

shell:
	docker compose run --rm $(PANDOC_SERVICE) sh

clean:
	rm -rf $(EPUB_DIR)
