#!/bin/sh

xset -b # disable bell

if [ -f ~/.Xmodmaprc ] ; then
  xmodmap ~/.Xmodmaprc
fi


if [ $(which urxvt | wc -l) -gt 0 ] ; then
  export TERMINAL=urxvt
fi

# Use slock through xautolock, but only if slock and xautolock exists.
if [ -f /usr/local/bin/slock ] && [ -f /usr/local/bin/xautolock ]; then
  xautolock -time 10 -locker slock &
fi
if [ -x /usr/local/bin/urxvtd ] ; then
  /usr/local/bin/urxvtd &
  export TERMINAL=urxvtc
fi
if [ $(which i3 | wc -l) -gt 0 ] ; then
  exec i3
fi
