#!/bin/sh

# Usage:  read my other scripts for in-depth steps on quality o' life techniques
#  most importantly you just run this in a folder with below video extensions an
# d it creates an audio only copy of each video, and places the original files a
# utomatically in a _vid subdir in the path you ran this in.
#
# $ split_audio_fr_vids.sh
#
# Uses:  I listen to my music offline because streaming costs money and uses cop
# ious amounts of bandwidth and electricity unnecessarily, and vlc works just as
# great on a portable as it does elsewhere, with background playback enabled. Al
# so, OSTs for most games are not available through anywhere to be streamed. Mos
# t importantly I've done it this way since MP3 players came around and later th
# rough phones when those could play back audio files with a multimedia player.
# Lastly i run this on yt-dlp downloaded videos, so with a simple Gorillaz music
# video (e.g), which could be <70mb and the audio only 4mb. So, the transferring 
# and track loading is instant with a smaller file like that,  and it won't show
# up in the Video tab, instead of Audio tab, in VLC, on my pocketed device.
#


mkdir -p _vid || exit 1

# Find videos:
found=0

for FILE in *.mp4 *.mkv *.mov *.avi *.flv *.webm; do
    [ ! -f "$FILE" ] && continue

    found=1
    TMP=".tmp.$$.$FILE"

    echo "Processing:  $FILE"

    # ffmpeg args (url):  https://ffmpeg.org/ffmpeg-all.html

    if ffmpeg -n -i "$FILE" -vn -acodec copy "$TMP"; then
        mv -n "$FILE" "_vid/$FILE"
        mv "$TMP" "$FILE"
        echo "Ready:  $FILE"
    else
        echo "Audio separation failed:  $FILE"
        rm -f "$TMP"
    fi
done
if [ $found -eq 0 ]; then
    echo "No videos in the current directory!"
fi

