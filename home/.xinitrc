#!/bin/sh

xset -b # disable bell

BG_IMAGE_PATH="${BG_IMAGE_PATH:-$HOME/Downloads/dark-purple-city01.jpg}"

if [ -f ~/.Xmodmaprc ] ; then
  xmodmap ~/.Xmodmaprc
fi

eval $(ssh-agent)

if [ $(which urxvt | wc -l) -gt 0 ] ; then
  export TERMINAL=urxvt
fi

# Use slock through xautolock, but only if slock and xautolock exists.
if [ -x $(command -v xautolock) ] ; then
  if [ -x $(command -v i3lock) ]; then
    xautolock -time 10 -locker 'i3lock -c 000000' &
  elif [ -x $(command -v slock) ]; then
    xautolock -time 10 -locker slock &
  fi
fi

if [ -x $(command -v urxvtd) ] ; then
  urxvtd &
  export TERMINAL=urxvtc
fi

if [ -f "$BG_IMAGE_PATH" ] ; then
  feh --bg-scale $BG_IMAGE_PATH
fi
if [ -x $(command -v i3) ] ; then
  exec i3
fi
