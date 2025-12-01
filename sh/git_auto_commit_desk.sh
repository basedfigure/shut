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
GIT="/mnt/dump_dsk/CENTR/WRK/_lan/DESK"

cd "$GIT" || exit 1
git add .
git commit -m "Work"
git push