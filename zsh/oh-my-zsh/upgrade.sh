#!/usr/bin/env bash

set -eu

# path: https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/lib/compfix.zsh
for f in $(ls lib) ; do
  echo $f
  curl -L "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/lib/$f" > "lib/$f"
done
echo "done"

