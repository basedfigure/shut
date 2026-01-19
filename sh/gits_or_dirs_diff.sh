# Script to print a comparison between two directories or git repositories for e
# ach file's existence in them,   or a combination of a raw filesystem directory
# and a git, between their files.
#
# Usage:
# Tab to autocomplete in Konsole, after you've given chmod permission:
#  diff_gits_or_dirs.sh  dir/path dir2/path
#
# Uses:
# This saves me from getting lost when i happen to have a git and a correspondin
# dupe that is basically out of sync; for i need to make sure that i didn't miss 
# anything bwtween them.
#
# To see the formatted prints, check my screenshot here:
#  codeberg.org/basedfigure/foot/media/branch/main/attch/juju_sh_-_gits_or_dirs_diff.png
#

#!/usr/bin/env bash
set -o pipefail

DIR1="$1"
DIR2="$2"

if [[ -z "$DIR1" || -z "$DIR2" ]]; then
  echo "Usage: $0 <dir1> <dir2>"
  exit 1
fi

if [[ ! -d "$DIR1" || ! -d "$DIR2" ]]; then
  echo "Each arg must be a directory"
  exit 1
fi

# Print colors:
GREEN="\033[32m"
RED="\033[31m"
YELLOW="\033[33m"
RESET="\033[0m"  # no color

echo -e "\n Comparing:"
echo "  $DIR1"
echo "  $DIR2"
echo

is_git1=false
is_git2=false
[[ -d "$DIR1/.git" ]] && is_git1=true
[[ -d "$DIR2/.git" ]] && is_git2=true

list_files() {
local dir="$1"
local is_git="$2"

if [[ "$is_git" == true ]]; then
  (
    cd "$dir" &&
    git ls-files --cached --others --exclude-standard
  )
else
  (
    cd "$dir" &&
    find . -type f \
      ! -path './.git/*' \
      | sed 's|^\./||'
  )
fi
}

mapfile -t files1 < <(list_files "$DIR1" "$is_git1" | sort)
mapfile -t files2 < <(list_files "$DIR2" "$is_git2" | sort)

common=$(comm -12 <(printf "%s\n" "${files1[@]}") <(printf "%s\n" "${files2[@]}"))
only1=$(comm -23 <(printf "%s\n" "${files1[@]}") <(printf "%s\n" "${files2[@]}"))
only2=$(comm -13 <(printf "%s\n" "${files1[@]}") <(printf "%s\n" "${files2[@]}"))

if [[ -n "$common" ]]; then
  while IFS= read -r file; do
    if diff -q "$DIR1/$file" "$DIR2/$file" >/dev/null; then
      echo -e "${GREEN}SAME${RESET}  $file"
    else
      echo -e "${RED}DIFF${RESET}  $file"
    fi
  done <<< "$common"
fi

if [[ -n "$only1" ]]; then
  while IFS= read -r file; do
    echo -e "${YELLOW}+ ONLY IN DIR1${RESET}  $file"
  done <<< "$only1"
fi

if [[ -n "$only2" ]]; then
  while IFS= read -r file; do
    echo -e "${YELLOW}- ONLY IN DIR2${RESET}  $file"
  done <<< "$only2"
fi




