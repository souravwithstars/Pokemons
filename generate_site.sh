#! /bin/bash
source "scripts/generate_htmls.sh"

DATABASE="source/data/pokemon.csv"
CARD_TEMPLATE="scripts/templates/card.html"
HTML_DIR="html"

rm -rf ${HTML_DIR}

mkdir ${HTML_DIR}
cp -r source/images ${HTML_DIR}/images
cp source/style.css ${HTML_DIR}

generate_all_html "${DATABASE}" "${CARD_TEMPLATE}" "${HTML_DIR}"

# open "${HTML_DIR}/all.html"