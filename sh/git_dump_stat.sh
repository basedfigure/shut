#!/bin/bash

# Calls a porcelain 'git status' command, for all repos, so i can see what i was
#working on, from their staging areas, so i don't have to do them one by one.

# Dry:
root="/mnt/dump_dsk/CENTR/WRK"

declare -A repos=(
  # prof
  [bf]="$root/bf"
  [bfnet]="$root/www"
  
  # main
  [juju]="$root/juju/"
  [hood]="$root/hood"
  [dojo]="$root/dojo"
  [punk]="$root/punk"

  # io
  [mod]="$root/mod"
  [foot]="$root/foot"
  [gut]="$root/gut"
  [wurl]="$root/wurl"
  [save]="$root/save"

  # zzz
  [sage]="$root/sage"
  [jakd]="$root/jakd"
)

names=("$@")
[[ ${#names[@]} -eq 0 ]] && names=("${!repos[@]}")

for name in "${names[@]}"; do
  repo="${repos[$name]}"
  
  if [[ -z "$repo" ]]; then
    echo "[ $name ] (not found)"
    echo
    echo
    continue
  fi

  echo "[ $name ]"
  
  out=$(git -C "$repo" status --porcelain | cut -c4-)

  if [[ -z "$out" ]]; then
    echo "clear"
  else
    echo "$out" | sort | awk -F/ '
    {
      dir=$1
      if (NF==1) dir="/"
      if (dir!=prev) {
        print "-- " dir " --"
        prev=dir
      }
      if (NF>1) {
        sub(dir"/","")
        print
      } else 
      {
        print $0
      }
   }'
 fi

  echo
  echo # extra separation
done