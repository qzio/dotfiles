#!/usr/bin/env bash
set -eu
echo "
Installing

- k9s
- kubectx

"
set -x
ARCH=amd64
MACHINE_TYPE=$(uname -m)
KERNEL_NAME=$(uname -s)
K9S_VERSION=0.24.4
KUBECTX_VERSION=0.6.3


usage()
{
  echo "$@"
  echo "usage: ./$0"
  exit 1
}

main()
{
  setup
  install_k9s
  install_kubectx
}

setup()
{
  mkdir -p $HOME/bin
  mkdir -p $HOME/Downloads/
}

install_k9s()
{
  if [ $(command -v k9s | wc -l) -gt 0 ] ; then
    echo "k9s already installed"
    return 0
  fi
  pushd $HOME/Downloads
  filename=k9s_${KERNEL_NAME}_${MACHINE_TYPE}.tar.gz
  curl -OL https://github.com/derailed/k9s/releases/download/v$K9S_VERSION/${filename}
  tar xf ${filename}
  mv k9s $HOME/bin/
  popd
}

install_kubectx()
{
  if [ $(command -v kubectx | wc -l) -gt 0 ] ; then
    echo "kubectx already installed"
    return 0
  fi
  pushd $HOME/Downloads
  curl -OL https://github.com/ahmetb/kubectx/archive/v${KUBECTX_VERSION}.tar.gz
  tar -xf v${KUBECTX_VERSION}.tar.gz
  mv kubectx-${KUBECTX_VERSION}/kubectx $HOME/bin/kubectx
  popd
}

main
