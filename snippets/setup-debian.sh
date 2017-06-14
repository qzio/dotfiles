#!/usr/bin/env bash

confirm()
{
  echo "$@"
  echo "continue with enter, ctrl-c to abort"
  read _
}

confirm "have you setup your ssh keys?"
confirm "lets install some packages!"

apt-get update
apt-get upgrade -y
apt-get install -y \
  mosh vim-nox procps tcpdump nmap build-essential \
  tmux unattended-upgrades git zsh \
  openvpn openconnect

confirm "install docker from https://docs.docker.com/engine/installation/linux/ubuntu/#install-using-the-repository"
confirm "install chruby, ruby-install and nvm, google site:github.com for 'em!"
