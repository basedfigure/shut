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
# - Search file by name from TODO_DIRS.
# $ todo -fn word
#
# - Search text in TODO_DIRS.
# $ todo -a text
#
# - Fuzzy search file + text in TODO_DIR(S). Read interactivity notes here
# : fzf+todo
# $ todo -fzf text
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
  [hat]="$ROOT_DIR/hat"
  [now]="$ROOT_DIR/now"
  [safe]="$ROOT_DIR/safe"
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


# * File name search in TODO_DIR(S), with fzf (fuzzy finder),
# so you can search any pattern of letters and words, lightning fast:
#
# Install (apt):  fzf
# - utility
#
elif [ "$1" = "-fn" ]; then
  shift

  if [ -z "$*" ]; then
    echo "Input filename search text"
    exit 1
  fi

  SEARCH="$*"

  if [ -d "$TODO_DIR" ]; then
    echo
    echo "$TODO_DIR:"
    find "$TODO_DIR" -type f -printf "%f\n" | fzf --filter="$SEARCH" --no-sort --exact
  fi

  for DIR in "${TODO_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
      echo
      echo "$DIR:"
      find "$DIR" -type f -printf "%f\n" | fzf --filter="$SEARCH" --no-sort --exact
    fi
  done



# Word search, with color coding:  grep
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


# * Fuzzy file + word search, interactively, inside all the given dirs
# : fzf+todo
# Install (apt):  $ sudo apt install fzf
#
# FZF + todo.sh:
# - color coded output.
# - search interactively, after initial search, in FZFs CLI.
# - interactive line selection, with up/down arrows.
# - open the selected line, by line number, in Vim, by Enter.
# 
# Screenshot (url):
# codeberg.org/basedfigure/foot/media/branch/main/dojo/
# @
# juju_todo_bash_and_fzf_in_cli.png
# juju_todo_bash_and_fzf_in_cli_2_open_line_in_vim_upon_ret_key.png
#
elif [ "$1" = "-fzf" ]; then
  shift

  if [ $# -eq 0 ]; then
    echo "Input search text"
    exit 1
  fi

  SEARCH="$*"
  SEARCH_WORDS=("$@")
  ROOT_PREFIX="$ROOT_DIR"
  EDITOR_CMD="${EDITOR:-vim}"

  ALL_LINES=""

  get_lines() {
    local DIR="$1"
    find "$DIR" -type f | while read -r FILE; do
      awk -v root="$ROOT_PREFIX" -v f="$FILE" '
        {
          path = f
          sub("^" root "/", "", path)
          print path ":" FNR ":" $0
        }' "$FILE"
    done
  }

for DIR in "$TODO_DIR" "${TODO_DIRS[@]}"; do
  if [ -d "$DIR" ]; then
    ALL_LINES+=$(get_lines "$DIR")
    ALL_LINES+=$'\n'
  fi
done

FILTERED=$(awk -v words="${SEARCH_WORDS[*]}" '
  BEGIN { n = split(words, w, " ") }
  {
     match_all = 1
     for(i=1;i<=n;i++){
       if(index(tolower($0), tolower(w[i]))==0){
         match_all = 0
         break
       }
     }
     if(match_all) print
  }' <<< "$ALL_LINES")

  if [ -n "$FILTERED" ]; then
    SELECTED=$(echo "$FILTERED" | fzf --ansi --query="$SEARCH" --prompt="Search> ")

    if [ -n "$SELECTED" ]; then
      FILEPATH="${SELECTED%%:*}"
      LINE_NUM="${SELECTED#*:}"
      LINE_NUM="${LINE_NUM%%:*}"

      $EDITOR_CMD "+$LINE_NUM" "$ROOT_PREFIX/$FILEPATH"
    fi
  else
    echo "No matches found"
  fi



# * Dump of empty/nonempty files:
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