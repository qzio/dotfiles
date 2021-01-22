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
apt-get dist-upgrade -y
apt-get update
apt-get upgrade -y
apt-get install -y $(cat apt-packages/default)

apt-key add apt-keys.gpg
cp sources.list.d/* /etc/apt/sources.list.d/
cp preferences.d/* /etc/apt/preferences.d/
apt-get update
apt-get install -y $(cat apt-packages/third-party) --no-install-recommends
apt-get install -y -t unstable $(cat apt-packages/unstable)

if [ -d /rw ] ; then
  mkdir -p /rw/var/lib/docker
  (set +eu systemctl stop docker; echo 'docker stopped')
  if [ ! -l /var/lib/docker ] ; then
    rm -rf /var/lib/docker
    ln -sf /rw/var/lib/docker /var/lib/docker
  fi
fi


# if zsh is installed and the user 'user' is present, change the shell for 'user'
if [ -x /usr/bin/zsh ] ; then
  if [ $(egrep '^user:' /etc/passwd | wc -l) -gt 0 ] ; then
    if [ $(grep zsh /etc/passwd |grep user | wc -l) -lt 1 ] ; then
      chsh -s /usr/bin/zsh user
    fi
  fi
fi

# add user 'user' to the docker group, if they exist
if [ $(grep docker /etc/group | wc -l) -gt 0 ] ; then
  if [ $(egrep '^user:' /etc/passwd | wc -l) -gt 0 ] ; then
    if [ $(grep docker /etc/group |grep user |wc -l) -lt 1 ] ;then
      (set -x ; usermod -a -G docker user)
    fi
  fi
fi

if [ $(echo $@ | grep no-install-desktop | wc -l) -gt 0 ] ; then
  echo "not installing desktop packages"
else
  apt-get install -y $(cat apt-packages/desktop)

  mkdir -p /usr/share/fonts/truetype/SourceCodePro
  [ -d ../.fonts/ ] && cp ../.fonts/* /usr/share/fonts/truetype/SourceCodePro/

  if [ $(echo $@ | grep no-install-firefox | wc -l) -lt 0 ] ; then
    echo "not installing firefox, exit!"
    exit 0
  fi

  cp firefox-nightly.desktop /usr/share/applications/firefox-nightly.desktop
  mkdir -p /opt/
  [ -d /opt/firefox ] && echo "firefox already installed" && exit

  if [ -f firefox.tar.gz ] ; then
    echo "using local firefox.tar.gz file"
    tar xf firefox.tar.gz
    mv firefox /opt/
    chown user:user /opt/firefox
  else
    echo "will try to download firefox"
    pushd /opt
    curl -L "https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=linux64&lang=en-US" -o firefox.tar.gz
    tar -xvf firefox.tar.gz
    chown user:user -R firefox
    popd
  fi
fi
