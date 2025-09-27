#!/bin/sh

# - The pipx version of yt-dlp is needed for the most recent updates.
#   Install and update it with the following commands:
# $ sudo apt install pipx,
# $ pipx install yt-dlp,
# $ pipx upgrade yt-dlp

# - Give permissions locally for this script and run it:
# $ sudo chmod +x yt-dlp.sh
# $ ./yt-dlp.sh

~/.local/pipx/venvs/yt-dlp/bin/yt-dlp --no-cache-dir --config-location para.conf
