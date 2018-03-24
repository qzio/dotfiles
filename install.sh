#!/bin/sh
set -e
curdir=$(pwd)

main() {
  validate_curdir
  link_dotsymlinks
  link_home
}

validate_curdir() {
  if [ "$curdir" != "$HOME/dotfiles" ] ; then
    echo "*** STOP ***"
    echo "$curdir != $HOME/dotfiles"
    echo "you must be in your ~/ (\$HOME) when executing $(basename $0). your current work dir $(pwd)$(dirname $0) "
    echo "are you sure you want to continue with curdir: $curdir [y/n]?"
    read _answer
    if [ "$_answer" != "y" ] ; then
      echo "ok will exit."
      exit 1
    fi
    echo "wait... ARE YOU REALLY SURE????"
    read _answer
    if [ "$_answer" != "y" ] ; then
      echo "ok will exit."
      exit 1
    fi
  fi
}

link_dotsymlinks() {
  local filename=
  local target=
  local source=

  cd $curdir
  for symlink_source in `find $curdir -name "*.symlink" `; do
    filename=$(basename "$symlink_source")
    target="$HOME/.${filename%.*}"
    linkit "$symlink_source" "$target"
  done ;
}

link_home() {
  local f=
  local target=
  local source=

  cd $curdir
  for f in $(find home/ | sed 's/^home\///g' | grep -v .swp) ; do
    if [ "$(uname)" = "Linux" ] ; then
      source=$HOME/dotfiles/home/$f
      target=${HOME}/$f
    elif [ "$(uname)" = "FreeBSD" ] ; then
      source=$HOME/dotfiles/home/$f
      target=${HOME}/$f
    else
      source=$HOME/dotfiles/home$f
      target=${HOME}$f
    fi
    if [ ! -d $source ] ; then
      linkit $source $target
    fi
  done
}

# private

linkit()
{
  local from="$1"
  local target="$2"
  local filedir=$(dirname $target)

  if [ -f "$target" ] || [ -d "$target" ]; then
    if [ -L "$target" ] ; then
      echo "$target is already a symlink"
    else
      echo "$target already exists as a normal file"
    fi
  else
    if [ ! -d "$filedir" ] ; then
      echo "mkdir $filedir"
      mkdir -p $filedir
    fi
    echo "ln -sf $from $target"
    ln -sf "$from" "$target"
  fi
}

main
