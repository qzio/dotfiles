#!/bin/sh

set -eu

apt_useful="alacritty git ripgrep tmux curl libnotify-bin"
apt_secure="qubes-gpg-split openssh-client keepassxc ssh-askpass"
apt_qubes="qubes-core-agent-passwordless-root "\
  "qubes-core-agent-networking qubes-usb-proxy "\
  "qubes-utils qubes-vm-dependencies qubes-notification-agent" \
  ""
apt_extras="minisign netcat-openbsd iproute2 openssl nmap nftables xsel ldnsutils"

read -p "what kind of template?" templateKind

echo "got templateKind: $templateKind"

case $templateKind in
  app)
    (set -x; apt install -y $apt_useful $apt_secure $apt_qubes)
    ;;
  vault)
    (set -x; apt install -y $apt_useful $apt_secure $apt_extras)
    ;;
  *)
    echo "unsupported template $templateKind, [app|vault]"
    exit 1
esac

echo "minimal packages should be installed, please continue with ./base-dotfiles.sh"
echo "note: firefox and docker should probably be installed through their own apt sources."
echo "note: golang can be installed through apt, and then installed and updated through it self into $HOME/sdk/go instead of in the template"
echo "
    apt install golang
    go install golang.org/dl/go1.26.6@latest
    go1.26.6 download
  will download into $HOME/sdk/go1.26.6
  symlink that to $HOME/sdk/go and add $HOME/sdk/go/bin to \$PATH

