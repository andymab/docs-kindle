#!/bin/sh
set -e

FILE=$1

if [ -z "$FILE" ]; then
  echo "File not found"
  exit 1
fi

if [ -z "$KINDLE_EMAIL" ]; then
  echo "No Kindle email specified (KINDLE_EMAIL)"
  exit 1
fi

echo "Sending $FILE to Kindle..."

# Отправка через msmtp
echo "Kindle document" | mutt -s "Send to Kindle" \
    -a "$FILE" -- "$KINDLE_EMAIL" \
    -F scripts/msmtprc
