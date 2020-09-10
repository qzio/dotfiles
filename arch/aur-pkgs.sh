#!/usr/bin/env bash
set -eu
mkdir -p $HOME/src/aur
for repo in $(cat aur-list) ; do
  n=$(basename ${repo%.git})
  (set -x
  cd $HOME/src/aur

  if [ ! -d $n ] ; then
    git clone "$repo"
  fi
  cd "$n"
  git pull
  makepkg -si --noconfirm)
done
