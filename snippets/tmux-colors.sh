#!/usr/bin/env bash

c=1
for i in {17..255}; do
  printf "\x1b[38;5;${i}mcolour${i}\x1b[0m \t"
  [ $c -gt 5 ] && printf "\n" && c=0
  c=$(($c + 1))
done
printf "\n#### solarized 16 colors:\n\n"
c=1
for i in {0..16} ; do
  printf "\x1b[38;5;${i}mcolour${i}\x1b[0m \t"
  [ $c -gt 5 ] && printf "\n" && c=0
  c=$(($c + 1))
done
echo ""
