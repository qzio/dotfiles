#!/bin/sh

set -eu

repo=helix-editor/helix
release_location=$(curl -si "https://github.com/$repo/releases/latest" | grep location | cut -d ' ' -f2-)

# this is some really strange thing that goes on with the https:// here it removes chars
# printing it using something like echo.
#
# echo "hey: $release_location something"
# will print this:
# " something://github.com/helix-editor/helix/releases/tag/25.01"
#
# if we remove https:// it renders as expected.
#
release_location="$(curl -si "https://github.com/$repo/releases/latest" | grep location | cut -d ' ' -f2 | sed 's/https:\/\/github.com//g' | sed 's/\r//g')"
ver="$(basename $release_location)"
arch="$(uname -m)"
os="$(uname -s |  tr '[:upper:]' '[:lower:]')"

if [ "$os" = "Darwin" ]; then
  os=macos
fi
if [ "$arch" = "arm64" ] ;then
  arch=aarch64
fi

dlname="helix-${ver}-${arch}-${os}"
url="https://github.com/${repo}/releases/download/${ver}/${dlname}.tar.xz"

set -x
cd /tmp/
curl -o "$dlname.tar.xz" -L "$url"
tar -xvf "$dlname.tar.xz"
mkdir -p ~/bin
mv $dlname/hx ~/bin/
set +x
if [ ! -d ~/.config/helix ] ; then
  (set -x
  mkdir -p ~/.config/helix
  mv $dlname/runtime ~/.config/helix/)
fi
set -x
rm -rf $dlname.tar.xz
rm -rf $dlname
