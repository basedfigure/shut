#!/bin/bash
#
# 1) Inst (sak):  init
#
# 2) Usage:  $ set_alias.sh alias path/script.sh
#
# 3) Test run:  rc
# alias bark="/mnt/dump_dsk/CENTR/WRK/juju/sh/bark_print.sh"
# ..
# restart console
# $ bark -u
# 


SH_ALIAS="$1"
SH_PATH="$2"

if [[ -z "$SH_ALIAS" || -z "$SH_PATH" ]]; then
  echo "Usage: $0 <alias_name> <script_path>"
  exit 1
fi

SH_PATH="$(cd "$(dirname "$SH_PATH")" && pwd)/$(basename "$SH_PATH")"

if [[ -n "$ZSH_VERSION" ]]; then
  RC_FILE="$HOME/.zshrc"
else
  RC_FILE="$HOME/.bashrc"
fi

echo "alias $SH_ALIAS=\"$SH_PATH\"" >> "$RC_FILE"

echo "Alias '$SH_ALIAS' set in:  $RC_FILE"