#!/bin/sh

xinitlog()
{
  echo "$@" >> /home/user/xinitrc-log
}
echo "" > /home/user/xinitrc-log

xinitlog "I am running .xinitrc"

xset -b # disable bell

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
    xinitlog "using i3lock as locker"
    xautolock -time 10 -locker i3lock &
  elif [ -x $(command -v slock) ]; then
    xinitlog "using slock as locker"
    xautolock -time 10 -locker slock &
  fi
else
  xinitlog "no locker found..."
fi

if [ -x $(command -v urxvtd) ] ; then
  xinitlog "booting urxvtd"
  urxvtd &
  export TERMINAL=urxvtc
else
  xinitlog "no urxvtd"
fi
if [ -x $(command -v i3) ] ; then
  xinitlog "execing i3..."
  exec i3
fi
