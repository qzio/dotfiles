#!/bin/sh
mkdir -p $HOME/.zsh-plugins \
         $HOME/.zsh-completions

# generate extra completion files

# gcloud by apt
if [ ! -e $HOME/.zsh-plugins/gcloud.zsh ]; then
  # gcloud by apt
  if [ -f /usr/share/google-cloud-sdk/completion.zsh.inc ] ; then
    (set -x; ln -sf /usr/share/google-cloud-sdk/completion.zsh.inc $HOME/.zsh-plugins/gcloud.zsh)
  # gcloud by homebrew
  elif [ -f /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc ] ; then
    (set -x; ln -sf /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc  $HOME/.zsh-plugins/gcloud.zsh)
  fi
fi

# kubectl from kubectl
if [ ! -e $HOME/.zsh-plugins/kubectl.zsh ] && [ $(command -v kubectl | wc -l) -gt 0 ]; then
  (set -x; kubectl completion zsh > $HOME/.zsh-completions/_kubectl)
fi

# fzf from user installed fzf
if [ ! -e  $HOME/.zsh-plugins/fzf.zsh ] && [ -f $HOME/.fzf/shell/completion.zsh ] ; then
  (set -x; ln -sf $HOME/.fzf/shell/completion.zsh $HOME/.zsh-plugins/fzf.zsh)
fi

