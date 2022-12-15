#!/bin/sh
set -eu
CTOP_VERSION=0.7.7
KERNEL_NAME=$(uname -s | tr '[:upper:]' '[:lower:]')
CPU=$(uname -m)
ARCH="amd64"
if [ "$CPU" != "x86_64" ] ; then
  ARCH=arm64
fi


curl -L -o $HOME/bin/ctop https://github.com/bcicen/ctop/releases/download/v${CTOP_VERSION}/ctop-${CTOP_VERSION}-${KERNEL_NAME}-${ARCH}
chmod +x $HOME/bin/ctop
