#!/usr/bin/env bash
set -eu
set -x
ARCH=amd64
MACHINE_TYPE=$(uname -m)
KERNEL_NAME=$(uname -s)
K9S_VERSION=0.8.4
DOCKER_COMPOSE_VERSION=1.24.1
CTOP_VERSION=0.7.2


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
}

setup()
{
  mkdir -p $HOME/bin
  mkdir -p $HOME/Downloads/
}

install_k9s()
{
  pushd $HOME/Downloads
  curl -OL https://github.com/derailed/k9s/releases/download/$K9S_VERSION/k9s_${K9S_VERSION}_${KERNEL_NAME}_${MACHINE_TYPE}.tar.gz
  tar xf k9s_${K9S_VERSION}_${KERNEL_NAME}_${MACHINE_TYPE}.tar.gz
  mv k9s $HOME/bin/
  popd
}

install_docker_compose()
{
  curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-${KERNEL_NAME}-${MACHINE_TYPE} -o $HOME/bin/docker-compose
  chmod +x $HOME/bin/docker-compose
}

install_ctop()
{
  curl -L https://github.com/bcicen/ctop/releases/download/v${CTOP_VERSION}/ctop-${CTOP_VERSION}-${KERNEL_NAME,,}-${ARCH} -o $HOME/bin/ctop
  chmod +x $HOME/bin/ctop
}


main


