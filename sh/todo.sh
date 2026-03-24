#!/bin/bash
# bash instead of sh, for todo () in bashrc

# todo = Spanish for all, English for to-do.
#
# how:  jump down
#
# 1) This is a great system for the lone one and for team work, because agnostic
# files are easy to archive, share, move and write to, with any kind of content.
#
# 2) They're great for the console, GUI apps and based utilities.
#
# DESK/ - Konsole pathing:
# do/
#  - hat/ now/ safe/ stat/
# * hat/  root/*, home/ side/ misc/
# * stat/ is for what my console looks for with:  todo
# fr_tpad/
# word/
#  - done/
#
# Dumps a list of all files in do/stat/, formatted like this: "love wifeys.txt"
#
# Install:
# 1) Copy todo (), without comments (#) to $HOME/.bashrc:
#
# So, we're not in a subshell, but in an interactive shell (big shell).
#todo () {
#  cd /mnt/dump_dsk/CENTR/WRK/_lan/DESK/do/stat && todo.sh "$@"
#}
#
# 2) Relaunch terminal, after copying the routine.
# or..
# $ source ~/.bashrc
#
#
# * Usage:  how
# Commands, flags & arguments:
#
# - Add new todo/entry into stat/:
# $ todo -f "FILE" "content"
#
# - Search text in TODO_DIRS.
# $ todo -a text
#
# - Dump of empty/nonempty files.
# $ todo -l empty or.. nonempty
#
#
#$ todo -f "band of wives.txt" "append this line to it, even if the file exists"
#
# Why:
# askubuntu.com/questions/481715/why-doesnt-cd-work-in-a-shell-script
#
# * So, call TODOsh with an alias, so it cd's to your stat/ dir after the run.
#
#
# * Commands & relative paths:
# Tip:  if you need to open Konqueror from the Konsole's current path, call:
# $ konqueror .
#
# Similarly you can use my other scripts like
# $ convert_image_formats.sh ./ png
# .. to convert all images in the current directory.
#


ROOT_DIR="/mnt/dump_dsk/CENTR/WRK/_lan/DESK/do/"
TODO_DIR="$ROOT_DIR/stat" # Konsole based entries go here

declare -A TODO_DIRS=(
  #[hat]="$ROOT_DIR/hat"
  #[now]="$ROOT_DIR/now"
  #[safe]="$ROOT_DIR/safe"
  [word]="/mnt/dump_dsk/CENTR/WRK/_lan/DESK/word"
)

if [ "$1" = "-f" ]; then
  FILE="$2"

  if [ -z "$FILE" ]; then
    echo "Input the file name:  ./todo.sh -f \"file.txt\""
    exit 1
  fi

  shift 2
  TODO_TEXT="$*"

  if [ -z "$TODO_TEXT" ]; then
    echo "Input the to-do line to append to the file"
    exit 1
  fi

  echo "- $TODO_TEXT" >> "$TODO_DIR/$FILE"
  echo "Following appended to file:  $FILE"

# Word search:
elif [ "$1" = "-a" ]; then
  shift

  if [ -z "$*" ]; then
    echo "Input search text"
    exit 1
  fi

  for DIR in "${TODO_DIRS[@]}"; do

    echo
    echo "$DIR:"

    grep --color=always -Rn "$*" "$DIR" | awk -v prefix="$DIR/" '{sub(prefix,""); print}'

  done

# Dump of empty/nonempty files:
elif [ "$1" = "-l" ]; then
  MODE="$2"

  if [ -z "$MODE" ]; then
    echo "Use: -l empty | nonempty"
    exit 1
  fi

  for DIR in "${TODO_DIRS[@]}"; do

    echo
    echo "$DIR:"

    if [ "$MODE" = "empty" ]; then
      find "$DIR" -type f -empty -printf " %f\n"

    elif [ "$MODE" = "nonempty" ]; then
      find "$DIR" -type f ! -empty -printf " %f\n"

    else
      echo "Use: empty or nonempty"
      exit 1
    fi

  done

else
  cd "$TODO_DIR" || exit 1
  ls
fi

echo