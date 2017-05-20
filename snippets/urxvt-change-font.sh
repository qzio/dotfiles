#!/usr/bin/env bash
set -eu
FONTSIZE='13'
FONTSTYLE='antialias=true:hinting=true'
if [ -n "$1" ] ; then FONTSIZE="$1" ; fi

FONT="xft:Source\ Code\ Pro\ Medium:pixelsize=$FONTSIZE:$FONTSTYLE"
BOLD_FONT="xft:Source\ Code\ Pro\ Black:pixelsize=$FONTSIZE:$FONTSTYLE"

if [ -n "${TMUX:-}" ]; then
  printf '\ePtmux;\e\e]710;%s\007\e\\' "$FONT"
  printf '\ePtmux;\e\e]711;%s\007\e\\' "$BOLD_FONT"
else
  printf '\e]710;%s\007' "$FONT"
  printf '\e]711;%s\007' "$BOLD_FONT"
fi
