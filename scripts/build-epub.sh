#!/bin/sh
set -e

SRC=$1

if [ -z "$SRC" ]; then
  echo "Usage: build-epub.sh docs/docker/index.md"
  exit 1
fi

NAME=$(basename "$(dirname "$SRC")")
OUT="epub/$NAME.epub"

pandoc "$SRC" \
  --toc \
  --metadata title="$NAME" \
  --css styles/kindle.css \
  -o "$OUT"

echo "EPUB created: $OUT"
