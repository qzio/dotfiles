#!/bin/sh

xset -b # disable bell

BG_IMAGE_PATH="${BG_IMAGE_PATH:-}"

if [ -f ~/.Xmodmaprc ] ; then
  xmodmap ~/.Xmodmaprc
fi

eval $(ssh-agent)

# Use slock through xautolock, but only if slock and xautolock exists.
if [ -x $(command -v xautolock) ] ; then
  if [ -x $(command -v i3lock) ]; then
    xautolock -time 10 -locker 'i3lock -c 000000' &
  elif [ -x $(command -v slock) ]; then
    xautolock -time 10 -locker slock &
  fi
fi

if [ $(which urxvt | wc -l) -gt 0 ] ; then
  export TERMINAL=urxvt
fi

if [ -x $(command -v urxvtd) ] ; then
  urxvtd &
  export TERMINAL=urxvtc
fi

if [ -x $(command -v alacritty) ] ; then
  export TERMINAL=alacritty
fi


if [ -f "$BG_IMAGE_PATH" ] ; then
  feh --bg-scale $BG_IMAGE_PATH
else
  xsetroot -solid '#303030'
fi
if [ -x $(command -v i3) ] ; then
  exec i3
fi
