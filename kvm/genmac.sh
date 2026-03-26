#!/bin/sh
m="52:54:00"
m="$m:$(od -An -N1 -t xC /dev/urandom | sed 's/ //g')"
m="$m:$(od -An -N1 -t xC /dev/urandom | sed 's/ //g')"
m="$m:$(od -An -N1 -t xC /dev/urandom | sed 's/ //g')"
echo $m
