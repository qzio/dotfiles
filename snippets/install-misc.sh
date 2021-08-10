#!/usr/bin/env bash
set -eu
echo "
Installing

- k9s
- ctop
- kubectx

"
set -x
ARCH=amd64
MACHINE_TYPE=$(uname -m)
KERNEL_NAME=$(uname -s)
K9S_VERSION=0.24.4
DOCKER_COMPOSE_VERSION=1.24.1
CTOP_VERSION=0.7.2
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
  install_docker_compose
  install_ctop
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

install_docker_compose()
{
  if [ $(command -v docker-compose | wc -l) -gt 0 ] ; then
    echo "docker-compose already installed"
    return 0
  fi
  curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-${KERNEL_NAME}-${MACHINE_TYPE} -o $HOME/bin/docker-compose
  chmod +x $HOME/bin/docker-compose
}

install_ctop()
{
  if [ $(command -v ctop | wc -l) -gt 0 ] ; then
    echo "ctop already installed"
    return 0
  fi
  curl -L https://github.com/bcicen/ctop/releases/download/v${CTOP_VERSION}/ctop-${CTOP_VERSION}-${KERNEL_NAME,,}-${ARCH} -o $HOME/bin/ctop
  chmod +x $HOME/bin/ctop
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


