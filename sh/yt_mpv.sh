#!/bin/sh
# Usage:  $ yt_mpv.sh
# ..to echo all channels and tags
#
# Uses:  Playlists all videos from a channel in MPV and plays fr the latest one.
#
# These are my only subscriptions, for some downtime,  with quite many subs, for
# my taste. They're all worth watching, though.
#


usage() {
  echo "  "
  echo "* Usage:  yt_mpv.sh case"
  echo "  "
  echo "  # code:"
  echo "  badsector"
  echo "  malb42"
  echo "  eskil"
  echo "  ipeproto"
  echo "  "
  echo "  # gnu:"
  echo "  kernotex"
  echo "  kris"
  echo "  "
  echo "  # rpg:"
  echo "  woodwwad"
  echo "  "
  echo "  # ware:"
  echo "  8bitguy"
  echo "  savage"
  echo "  "
  echo "  # play:"
  echo "  mattchat"
  echo "  retku1"
  echo "  retku2"
  echo "  tmr"
  echo "  vinc"
  echo "  jwong"
  echo "  "
  echo "  # trig:"
  echo "  berlin"
  echo "  asmrgirl"
  echo "  mila"
  echo "  raynor"
  echo "  bungalow"
  echo "  abigail"
  echo "  risa"
  echi "  maya"
  echo "  "
  echo "  # poli:"
  echo "  johnnyharris"
  echo "  sotahistoria"
  echo "  cappy"
  echo "  "
  echo "  # mame:"
  echo "  trihex"
  echo "  whang"
}

case "$1" in

  # code:
  badsector)
    mpv https://www.youtube.com/@badsectoracula/videos
    ;;
  malb42)
    mpv https://www.youtube.com/@MALB42/videos
    ;;
  eskil)
    mpv https://www.youtube.com/@eskilsteenberg/videos
    ;;
  ipeproto)
    mpv https://www.youtube.com/@ipeprotoipe9122/videos
    ;;

  # gnu:
  kernotex)
    mpv https://www.youtube.com/@Kernotex/videos
    ;;
  kris)
    mpv https://www.youtube.com/@DigitalMetal/videos
    ;;

  # rpg:
  woodwwad)
    mpv https://www.youtube.com/@woodwwad/videos
    ;;

  # ware:
  8bitguy)
    mpv https://www.youtube.com/@The8BitGuy/videos
    ;;
  savage)
    mpv https://www.youtube.com/@tested/videos
    ;;

  # play:
  mattchat)
    mpv https://www.youtube.com/@MattBarton/videos
    ;;
  retku1)
    mpv https://www.youtube.com/@NESRetku/videos
    ;;
  retku2)
    mpv https://www.youtube.com/@Retkunholvi/videos
    ;;
  tmr)
    mpv https://www.youtube.com/@TheMexicanRunner/videos
    ;;
  vinc)
    mpv https://www.youtube.com/@davidvinc/videos
    ;;
  jwong)
    mpv https://www.youtube.com/@jwonggg
    ;;

  # trig:
  berlin)
    mpv https://www.youtube.com/@asmrberlinn/videos
    ;;
  asmrgirl)
    mpv https://www.youtube.com/@ASMRGIRL321/videos
    ;;
  mila)
    mpv https://www.youtube.com/@milahiasmr/videos
    ;;
  raynor)
    mpv https://www.youtube.com/@brandonraynor/videos
    ;;
  bungalow)
    mpv https://www.youtube.com/@bungalowasmr1/videos
    ;;
  abigail)
    mpv https://www.youtube.com/@ASMR.by.Abigail/videos
    ;;
  risa)
    mpv https://www.youtube.com/@TheRisaASMR/videos
    ;;
  maya)
    mpv https://www.youtube.com/@AlsoMayaASMR
    ;;

  # poli:
  johnnyharris)
    mpv https://www.youtube.com/@johnnyharris/videos
    ;;
  sotahistoria)
    mpv https://www.youtube.com/@sotaajahistoriaapodi/videos
    ;;
  cappy)
    mpv https://www.youtube.com/@ChrisCappy/videos
    ;;

  # mame:
  trihex)
    mpv https://www.youtube.com/@trihex/videos
    ;;
  whang)
    mpv https://www.youtube.com/@JustinWhangYt/videos
    ;;

  *)
    usage
    exit 1
    ;;
esac