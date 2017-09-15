#!/bin/sh

CMD=setxkbmap
KBMAP_NAME=en_US
CACHE_FILE="$HOME/.latest-keymap"

usage()
{
  echo "usage:\n  $0 [se|en|toggle]"
  exit 1
}
[ $# -lt 0 ] && usage


[ ! -f $CACHE_FILE ] && echo "$KBMAP_NAME" > $CACHE_FILE

if [ $(echo "$1" | grep se | wc -l) -gt 0 ] ; then
  KBMAP_NAME=se
elif [ $(echo "$1" | grep en | wc -l) -gt 0 ] ; then
  KBMAP_NAME=en_US
else
  echo "doing toggle"
  if [ "$(cat $CACHE_FILE)" = "se" ] ; then
    KBMAP_NAME=en_US
  else
    KBMAP_NAME=se
  fi
fi
# default KBMAP_NAME=en_US, no need for an else

set -x

echo "$KBMAP_NAME" > $CACHE_FILE
$CMD $KBMAP_NAME
xmodmap ~/.Xmodmaprc
