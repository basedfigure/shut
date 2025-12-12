#!/bin/bash

# Usage:
#  Install (apt):  dwebp, ffmpeg
# 
# Give chmod permission for the script and run with:
#  ./convert_image_formats.sh /path/file | folder  target_format
#
# Note:
#  The script places all original converted files in a "_convert" folder, in the 
# designated path.


path="$1"
target_format="$2"
_convert_dir="_convert"


if [[ -z "$path" ]] || [[ -z "$target_format" ]]; then
    echo "Usage: $0 /path/file | folder  target_format"
    exit 1
fi


# --- Defines supported source formats and respective converters ---
declare -A converters
converters=(
    ["webp"]="dwebp {input} -o {output}"
    ["avif"]="ffmpeg -y -i {input} {output}"
)


# --- Routine to convert file ---
convert_file() {
    local file="$1"
    local ext="${file##*.}"
    ext="${ext,,}"  # lower case

    # Skip in case file format is not in list of supported formats
    if [[ -z "${converters[$ext]}" ]]; then
        return
    fi

    local dir base out cmd
    dir="$(dirname "$file")"
    base="$(basename "$file" ".$ext")"
    out="$dir/$base.$target_format"
    mkdir -p "$dir/$_convert_dir"

    # Forms the convert command
    cmd="${converters[$ext]}"
    cmd="${cmd//\{input\}/\"$file\"}"
    cmd="${cmd//\{output\}/\"$out\"}"

    echo "Converting: $file → $out"
    eval $cmd >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        echo "OK: $file → $out"
        # Move original only on succesful conversion
        mv "$file" "$dir/$_convert_dir/"
        echo "Moved original file to _convert_dir: $file"
    else
        echo "Error: conversion failed: $file"
    fi
}


# --- File ---
if [[ -f "$path" ]]; then
    convert_file "$path"
    exit 0
fi


# --- Directory ---
if [[ -d "$path" ]]; then
    shopt -s nullglob nocaseglob
    # Processes all files in the folder
    for file in "$path"/*; do
        [[ -f "$file" ]] || continue
        convert_file "$file"
    done
    exit 0
fi


echo "Error: no such path."
exit 1
