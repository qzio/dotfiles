#!/bin/sh

set -eu

echo "add docker sources and installs docker-ce"


#[ $(dpkg -l |grep docker-ce|wc -l) -gt 0 ] && echo "already installed" && exit 1

(
  set -x
  curl -L https://download.docker.com/linux/debian/gpg \
       -o /etc/apt/keyrings/docker.asc
)

# lets check fingerprint
fp='9DC858229FC7DD38854AE2D88D81803C0EBFCD88'
mkdir -p ~/.gnupg
chmod 700 ~/.gnupg
file_fp=$(gpg -n -q --import --import-options import-show /etc/apt/keyrings/docker.asc |grep -E '^ +'|tr -cd 'A-Z0-9')

if [ "$fp" != "$file_fp" ] ; then
  echo "fingerprint does not match"
  echo "expected: $fp"
  echo "got:      $file_fp"
  exit 1
fi

set -x
cat > /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

apt update && apt install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-compose-plugin \
  docker-buildx-plugin
