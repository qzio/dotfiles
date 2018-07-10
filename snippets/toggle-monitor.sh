#!/usr/bin/env bash
set -eu
internal_monitor()
{
  if [ $(xrandr -q |grep LVDS-1|wc -l) -gt 0 ] ; then
    echo "LVDS-1"
  fi
}
external_monitor() {
  if [ $(xrandr -q |grep DP-1|wc -l) -gt 0 ] ; then
    echo "DP-1"
  elif [ $(xrandr -q |grep HDMI-1|wc -l) -gt 0 ] ; then
    echo "HDMI-1"
  else
    echo "unable to determine external monitor"
    echo "this script only supports HDMI-1 and DP-1"
    exit 1
  fi
}

ext_mode() {
  if [ $(external_monitor) == "DP-1" ] ; then
    echo "--mode 2560x1440"
  else
    echo "--auto"
  fi
}

connected_monitors()
{
  xrandr -q | grep ' connected ' |awk '{print $1}'
}

ext=$(external_monitor)

if [ $(connected_monitors | grep $ext | wc -l) -gt 0 ] ; then
  echo "Found an external monitor, only use it?"
  read ans
  if [ $ans == "y" ] ; then
    xrandr --output $ext $(ext_mode)
    echo "ok should I shut off the internal monitor?"
    read ans
    if [ $ans == "y" ] ; then
      xrandr --output $(internal_monitor) --off
    fi
  else
    echo "you did not answer y, will not use it at all"
    echo "xrandr --output $ext --off"
    xrandr --output $(internal_monitor) --auto
    exit 1
  fi
else
  echo "Did not find any valid monitors"
fi
