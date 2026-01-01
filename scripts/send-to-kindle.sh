#!/bin/sh
set -e

FILE=$1

if [ ! -f "$FILE" ]; then
  echo "File not found"
  exit 1
fi

echo "Sending $FILE to Kindle..."

echo "Kindle document" | \
  mutt -s "Send to Kindle" \
  -a "$FILE" -- "$KINDLE_EMAIL"
