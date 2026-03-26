#!/bin/sh
set -eu

ALPINE_VER="3.20.0"
OSVARIANT="alpinelinux3.17"

usage() {
  echo $@
  echo "usage: $0 <name> <vcpus> <memory> <disk size>"
  echo ""
  echo "example: $0 k3s-control 2 1024 50"
  echo "result: name k3s-control"
  echo "        vcpus: 2"
  echo "        memoroy: 1024MB"
  echo "        disk: 50GB"
  echo ""
  exit 1
}
name=${1:-}
vcpus=${2:-}
memory=${3:-}
disk=${4:-}


[ ! -n "$name" ] && usage "missing name"
[ ! -n "$vcpus" ] && usage "missing vcpus"
[ ! -n "$memory" ] && usage "missing memory"
[ ! -n "$disk" ] && usage "missing disk"

[ ! -f "./alpine-virt-${ALPINE_VER}-x86_64.iso" ] && usage "missing alpine iso\ncurl -OL https://dl-cdn.alpinelinux.org/alpine/v3.20/releases/x86_64/alpine-virt-${ALPINE_VER}-x86_64.iso"


echo "sudo virt-install \
  --name $name \
  --vcpus=$vcpus \
  --memory=$memory \
  --cdrom ./alpine-virt-${ALPINE_VER}-x86_64.iso \
  --disk size=$disk \
  --os-variant=$OSVARIANT \
  --graphics none \
  --network default
"
