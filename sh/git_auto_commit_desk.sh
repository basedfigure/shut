#!/bin/bash

# 1.  Prepare script:
#
# sudo chmod +x /mnt/dump_dsk/CENTR/WRK/juju/sh/git_auto_commit_desk.sh

# 2.  Prepare cron job to run every 2h or 1min, by opening ..
#
# crontab -e
#
#   ..and by pasting the following on the last line
# 0 */2 * * * /mnt/dump_dsk/CENTR/WRK/juju/sh/git_auto_commit_desk.sh >/dev/null 2>&1
#
#   ..to test it and echo the console to a temporary log,  commit every minute 
# * * * * * /mnt/dump_dsk/CENTR/WRK/juju/sh/git_auto_commit_desk.sh >> /tmp/gitcron.log 2>&1


# Git commit the following repo's changes with a generic message, so it's fire and forget.
#   Note to self:   keep this script in particular intentionally basic:


LOG="/home/bf/Desktop/cron_git_auto_commits.txt"
exec >>"$LOG" 2>&1

TOG_SUCC=0


open_file() {
  [ -n "$DISPLAY" ] && kwrite "$LOG" &
}

failed() {
  echo "Error: $1"
  [ -n "$DISPLAY" ] && kwrite "$LOG" &
  exit 1
}

git_run() {
  local git="$1"
  cd "$git" 		 || failed "cd $git"
  git add .  		 || failed "add"

  if git diff-index --quiet HEAD --; then
    echo "No changes to commit in $git"
  else
    git commit -m "Work" || failed "commit"
    git push 		 || failed "push"
  fi
}

git_run "/mnt/dump_dsk/CENTR/WRK/_lan/DESK"
git_run "/mnt/dump_dsk/CENTR/WRK/_lan/WSPC"


if [ "$TOG_SUCC" -eq 1 ]; then
  open_file
fi