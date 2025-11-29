#!/bin/bash

# 1. Prepare script:
#
# sudo chmod +x /mnt/dump_dsk/CENTR/WRK/juju/sh/git_auto_commit_desk.sh


# 2. Prepare cron job to run every 2h:
#
# crontab -e
# 0 */2 * * * /mnt/dump_dsk/CENTR/WRK/juju/sh/git_auto_commit_desk.sh >/dev/null 2>&1


GIT="/mnt/dump_dsk/CENTR/WRK/_lan/DESK"

cd "$GIT" || exit 1
git add .
git commit -m "Work"
git push