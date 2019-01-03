#!/usr/bin/env bash
set -eux
FZF_GITHUB=https://github.com/junegunn/fzf.git

git clone $FZF_GITHUB ~/.fzf
cd ~/.fzf
./install --bin


