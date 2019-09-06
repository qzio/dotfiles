#!/usr/bin/env bash
PLUGIN_DIR=~/.cache/dein
INSTALL_DIR="${PLUGIN_DIR}/repos/github.com/Shougo/dein.vim"
mkdir -p "$PLUGIN_DIR"
git clone https://github.com/Shougo/dein.vim "$INSTALL_DIR"
echo "Done."
