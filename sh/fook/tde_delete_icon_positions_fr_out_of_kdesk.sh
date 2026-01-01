#!/bin/bash

ICONPOS="$HOME/.trinity/share/apps/kdesktop/IconPositions"

echo "Nicely quit kdesktop if ya can"
kdesktop --quit 2>/dev/null
sleep 1

if pgrep kdesktop >/dev/null; then
    echo "kdesktop on,  forcing SIGTERM..."
    pkill -TERM kdesktop
    sleep 1
fi

if pgrep kdesktop >/dev/null; then
    echo "kdesktop not closing,  forcing SIGKILL..."
    pkill -KILL kdesktop
    sleep 1
fi

if pgrep kdesktop >/dev/null; then
    echo "Err:  couldn't stop kdesktop"
    exit 1
fi

echo "Deleting IconPositions file"
rm -f "$ICONPOS"

echo "Restarting kdesktop"
kdesktop & disown

echo "Donezo"