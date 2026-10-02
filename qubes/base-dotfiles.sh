#!/bin/sh

if [ ! -f $HOME/.config/alacritty/alacritty.toml ] ; then
  echo "writing alacritty.toml"
  mkdir -p $HOME/.config/alacritty
  cat > $HOME/.config/alacritty/alacritty.toml <<EOF
[font]
  size=8
EOF
  cat $HOME/.config/alacritty/alacritty.toml
fi

if [ ! -f $HOME/.bash_aliases ] ; then
  echo "writing .bash_aliases"
  cat > $HOME/.bash_aliases <<EOF
# Use the most modern vim present
export EDITOR=vi
alias vim=vi
if [ -x "\$(which vim)" ] ; then
  export EDITOR=vim
  unalias vim
elif [ -x "\$(which nvim)" ] ; then
  export EDITOR=nvim
  unalias vim
  alias vim=nvim
fi

# use the best grep-like command
if [ \$(command -v rg) ] ; then
  alias g='rg -i'
elif [ \$(command -v ag) ] ; then
  alias g=ag
elif [ \$(command -v ack) ] ; then
  alias g=ack
else
  alias g='grep -i'
fi
EOF
  cat $HOME/.bash_aliases

fi

if [ $(command -v tmux) ] ; then
  if [ ! -f $HOME/.tmux.conf ] ; then
    echo "writing $HOME/.tmux.conf"
    cat > $HOME/.tmux.conf <<EOF
# Increase scrollback
set-option -g history-limit 10000
set -g default-terminal "screen-256color"
# get ctrl-arrow  to move between words
set-window-option -g xterm-keys on

# use vi-based
set-window-option -g mode-keys vi
# fix slow escape times (annoying to have slow escape as a vim user)
set -sg escape-time 0
# vim key bindings to select panes.
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
  EOF
  fi
fi

if [ $(command -v zsh) ] ; then
  if [ ! -f $HOME/.zshrc ] ; then
    echo "writing .zshrc"
    cat > $HOME/.zshrc <<EOF
autoload compinit
autoload -Uz compinit
compinit -i
autoload -U +X bashcompinit && bashcompinit
bindkey -e
export HISTSIZE=10000
export SAVEHIST=5000
export HISTFILE=~/.history_zsh
[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases

EOF

    cat $HOME/.zshrc
  fi
elif [ $(command -v bash) ] ; then
  # noop
  echo "shell is probably bash, but will keep existing .bashrc unmodified"
fi
