#!/bin/sh

mkdir -p $HOME/.zsh-plugins
# extra completion files
if [ ! -e $HOME/.zsh-plugins/_gcloud.zsh ] && [ -f /usr/share/google-cloud-sdk/completion.zsh.inc ] ; then
  (set -x; ln -sf /usr/share/google-cloud-sdk/completion.zsh.inc $HOME/.zsh-plugins/_gcloud.zsh)
fi
if [ ! -e $HOME/.zsh-plugins/kubectl.zsh ] && [ $(command -v kubectl | wc -l) -gt 0 ]; then
  (set -x; kubectl completion zsh > $HOME/.zsh-plugins/_kubectl.zsh)
fi
if [ ! -e  $HOME/.zsh-plugins/_fzf.zsh ] && [ -f $HOME/.fzf/shell/completion.zsh ] ; then
  (set -x; ln -sf $HOME/.fzf/shell/completion.zsh $HOME/.zsh-plugins/_fzf.zsh)
fi

