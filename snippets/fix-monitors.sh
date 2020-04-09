#!/usr/bin/env bash

set -eux

xrandr --output DisplayPort-1 --rotate left --right-of DisplayPort-3
xrandr --output DisplayPort-3 --mode 2560x1440 --left-of DisplayPort-1
