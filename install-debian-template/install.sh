#!/usr/bin/env bash

set -eu

usage()
{
  echo "$@"
  echo "usage: $0 [no-firefox]"
  exit 1
}

[ ! $(id -u) -eq 0 ] && usage "You must be root to run this"
echo "ok..."

set -x
apt-get update
apt-get upgrade -y
apt-get install -y $(cat apt-packages/default)

apt-key add apt-keys.gpg
cp sources.list.d/* /etc/apt/sources.list.d/
cp preferences.d/* /etc/apt/preferences.d/
apt-get update
apt-get install -y $(cat apt-packages/third-party)
apt-get install -t unstable $(cat apt-packages/unstable)

if [ $(echo $@ | grep no-firefox | wc -l) -gt 0 ] ; then
  echo "not installing firefox"
else
  set -x
  cp firefox.desktop /usr/share/applications/firefox.desktop
  exit
  mkdir -p /opt/
  pushd opt
  curl -L https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=linux64&lang=en-US -o firefox.tar.gz
  tar -xvf firefox.tar.gz
  chown user:user -R firefox
  popd
fi
