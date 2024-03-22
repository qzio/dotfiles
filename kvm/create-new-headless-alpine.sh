#!/bin/sh
set -eu

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


echo "sudo virt-install \
  --name $name \
  --vcpus=$vcpus \
  --memory=$memory \
  --cdrom ./alpine-virt-3.17.1-x86_64.iso \
  --disk size=$disk \
  --os-variant=alpinelinux3.15 \
  --graphics none \
  --network default
"
