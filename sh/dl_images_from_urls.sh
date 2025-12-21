#!/bin/bash

# 1)  Install:
# Install the Firefox extension linked below, or some equivalent:
#
# https://addons.mozilla.org/en-US/firefox/addon/copy-selected-links/
#
# To manually copy a list of paint selected url:s from a page, select the images
# right-click, hit Copy selected links and paste them to pic.txt in the download
# directory.  Call this script from the pic.txt directory and look at it go.
# 
# You should point to your script directory in bashrc, to call the script out fr
# om any path, but replace it with your actual path:
#
# $ sed -i '$a export PATH="$PATH:/mnt/dump_dsk/CENTR/WRK/juju/sh"' ~/.bashrc
#
# $ sudo chmod +x /mnt/dump_dsk/CENTR/WRK/juju/sh/*
#
# 
# 2)  Usage:
# Call from your pic/ by autocompleting, by pressing tab with an optional path:
# $ dl_images_from_urls.sh  path/pic.txt
#
# You might want to use a test file to test it out with working sources and reas
# onably sized images. You can gut some url:s to your corresponding image folder
# s from my raw pic.txt here:
# 
# https://raw.githubusercontent.com/basedfigure/gut/refs/heads/main/www/pic.txt
#


set -euo pipefail

SH_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to pic.txt:
# 1) Optional argument
# 2) ..or from script path
#
PIC_URL="${1:-$PWD/pic.txt}"
[[ ! -f "$PIC_URL" ]] && PIC_URL="$SH_DIR/pic.txt"
[[ ! -f "$PIC_URL" ]] && { echo "Error: pic.txt not located" >&2; exit 1; }


# Creates the pic dir in pic.txt path:
#
PIC_DIR="$(dirname "$PIC_URL")/pic"
mkdir -p "$PIC_DIR"

while IFS= read -r url || [ -n "$url" ]; do
  [ -z "$url" ] && continue


  #  1) Direct image addresses (curl):
  #
  if [[ "$url" =~ \.(jpg|jpeg|png|webp|gif|bmp)(\?.*)?$ ]]; then
    echo "Direct image: $url"
    curl -L --fail -O --output-dir "$PIC_DIR" "$url"
    continue
  fi
  #

  
  #  2) HTML embedded image addresses (wget):
  #
  echo "HTML page: $url"

  html=$(wget -qO- "$url") || continue

  echo "$html" | \
  grep -oiP '<img[^>]+src\s*=\s*["'\'']\K[^"'\'']+' | \
  while IFS= read -r img; do

    # From relative to absolute url
    if [[ "$img" != http* ]]; then
      base="${url%/*}/"
      img="$base$img"
    fi

    echo " → $img"
    wget -nc -P "$PIC_DIR" "$img"

  done
  #

done < "$PIC_URL"

