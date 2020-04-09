#!/usr/bin/env bash
set -eu
branch=$(git branch | grep '^*'|awk '{print $2}')
echo -n "merge $branch pull request?[y/n]: "
read a
if [ "$a" != "y" ] ;then
  exit 1
fi
set -x
git co master
git merge $branch --no-ff
git push upstream master
git br -d $branch
git push origin :$branch

