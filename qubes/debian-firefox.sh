#!/bin/sh

# ref: https://support.mozilla.org/en-US/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-and-ubuntu-based-distributions-recommended

set -eu

echo "add mozilla sources and install latest firefox"

[ $(dpkg -l |grep firefox|wc -l) -gt 0 ] && echo "already installed" && exit 1

set -x
mkdir -p /etc/apt/keyrings
curl -L https://packages.mozilla.org/apt/repo-signing-key.gpg \
     -o /etc/apt/keyrings/packages.mozilla.org.asc

# lets check fingerprint
fp=35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'

cat > /etc/apt/sources.list.d/mozilla.sources << EOF
Types: deb
URIs: https://packages.mozilla.org/apt
Suites: mozilla
Components: main
Signed-By: /etc/apt/keyrings/packages.mozilla.org.asc
EOF
apt update && apt install -y firefox
