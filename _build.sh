#!/bin/sh

set -ev

BOOK_FILE='fullstack-textbook'
BOOK_TITLE='Building Full-Stack Web Applications'
AUTHOR='Fullstack Academy of Code'

Rscript -e "bookdown::render_book('index.Rmd', 'rmarkdown::md_document')"
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::epub_book')"

pandoc  \
  $BOOK_FILE.md \
  -o $BOOK_FILE.tex \
  --from markdown+yaml_metadata_block

pandoc \
  $BOOK_FILE.tex \
  -o $BOOK_FILE.pdf \
  --from latex \
  --template eisvogel-template.tex \
  --table-of-contents \
  --variable=titlepage:true \
  --variable=toc_own_page:false \
  --variable=title:"$BOOK_TITLE" \
  --variable=author:"$AUTHOR" \
  --variable=titlepage-color:"435488" \
  --variable=titlepage-text-color:"FFFFFF" \
  --variable=titlepage-rule-color:"FFFFFF"
