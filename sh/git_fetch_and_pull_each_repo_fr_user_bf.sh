#!/bin/bash

# Advice - mostly for Konsole noobs:
# * Auto complete by hitting tab, until you get the full file name and pick a nu
#   mber for the command, to show that many commits in the dump.
#
# $ git_fetch_and_pull_each_repo_fr_user_bf 16
# - Press ENTER to scroll with the pager, or q to quit. Scroll normally after it

set -euo pipefail

DEST_DIR="${DEST_DIR:-./repos}"

N_COMMITS="${1:-5}"

declare -A REPOS=(
  [juju]="github.com/basedfigure/juju"
  [dojo]="codeberg.org/basedfigure/dojo"
  [hood]="github.com/basedfigure/hood"
  [bf]="codeberg.org/basedfigure/bf"
  [punk]="codeberg.org/basedfigure/punk"
  [mod]="codeberg.org/basedfigure/mod"
  [foot]="https://codeberg.org/basedfigure/foot"
  [bfnet]="github.com/basedfigure/basedfigure.github.io"
  [save]="github.com/basedfigure/save"
  [gut]="github.com/basedfigure/gut"
  [jakd]="codeberg.org/basedfigure/jakd"
)

norm_git_url () {
  local url="$1"

  [[ "$url" =~ \.git$ ]] && { echo "$url"; return; }

  url="${url#https://}"
  url="${url#http://}"

  if [[ "$url" =~ ^github.com/ ]]; then
    echo "https://github.com/${url#github.com/}.git"
  else
    echo "https://${url}.git"
  fi
}

bark_log () {
  local repo_dir="$1"
  local repo_name="$2"

  echo
  echo "   $repo_name   last $N_COMMITS commits"
  echo ";--------------------------------------;"

  git -C "$repo_dir" log -n "$N_COMMITS" \
    --pretty=format:'%C(bold magenta)%h%Creset %C(cyan)%ad%Creset%n  %C(yellow)%s%Creset%n  %C(green)by %an%Creset%n' --date=relative || echo "no commits"

  echo
}

mkdir -p "$DEST_DIR"

for repo in "${!REPOS[@]}"; do
  raw_url="${REPOS[$repo]}"
  git_url=$(norm_git_url "$raw_url")

  target="$DEST_DIR/$repo"

  if [[ -d "$target/.git" ]]; then
    echo "pulling -> $repo"
    git -C "$target" pull --ff-only
  else
    echo "cloning -> $repo"
    git clone "$git_url" "$target"
  fi

  bark_log "$target" "$repo"
echo
done