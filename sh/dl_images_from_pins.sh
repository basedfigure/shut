#!/bin/bash
#
# Install (pipx):  gallery-dl
#
# Usage ($):  dl_images_from_pins.sh  url_by_user.txt
#
# Test (data):  ../io/url_by_user.txt
#

if [ -z "$1" ]; then
  echo "Usage:  $0 url_by_user.txt"
  exit 1
fi

export PATH="$HOME/.local/bin:$PATH"

INPUT_FILE="$1"
ROOT_OUTPUT_DIR="pins"
ARCHIVE_FILE="archive.bin"  # no need to touch this file

mkdir -p "$ROOT_OUTPUT_DIR"

while IFS= read -r url; do
  [ -z "$url" ] && continue
  [[ "$url" =~ ^#.*$ ]] && continue

  clean_url="${url%/}"
  dir_name="${clean_url##*/}"

  OUTPUT_DIR="$ROOT_OUTPUT_DIR/$dir_name"

  mkdir -p "$OUTPUT_DIR"

  echo "Downloading:  $url -> $OUTPUT_DIR"

  gallery-dl \
    --directory "$OUTPUT_DIR" \
    -o filename="{filename}.{extension}" \
    --download-archive "$ARCHIVE_FILE" \
    --no-mtime \
    "$url"

done < "$INPUT_FILE"

echo "Download complete"