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
if [ -x "\$(which nvim)" ] ; then
  export EDITOR=nvim
  unalias vim
  alias vim=nvim
elif [ -x "\$(which vim)" ] ; then
  export EDITOR=vim
  unalias vim
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

# base theme
set -g status-style "bg=default,fg=#7c7f8f"
set -g status-left " #H "
set -g status-right " %Y-%m-%d %H:%M "
set -g status-left-style "fg=#b744a1,bold"
set -g status-justify left
set -g window-status-format "#W "
set -g window-status-current-format "#W "
set -g window-status-current-style "fg=#e6e9ef,bold"
EOF
  fi
fi

if [ $(command -v zsh) ] ; then
  if [ ! -f $HOME/.zshrc ] ; then
    echo "writing .zshrc"
    cat > $HOME/.zshrc <<EOF
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit
autoload -U promptinit && promptinit
autoload -U colors && colors
bindkey -e
setopt  prompt_subst
export PROMPT='%{\$fg[magenta]%}%m%{\$reset_color%}:%{\$fg[green]%}%3~%B%{\$reset_color%}%(!.#.$) '
export HISTSIZE=10000
export SAVEHIST=5000
export HISTFILE=~/.history_zsh
export LC_TIME=C.UTF-8
export LC_CTYPE=en_US.UTF-8
[ -f \$HOME/.bash_aliases ] && source \$HOME/.bash_aliases
[ -f \$HOME/.shell_extras ] && source \$HOME/.shell_extras
# default bashrc has this
alias ls='ls --color=auto'


# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word
bindkey '^r' history-incremental-search-backward
EOF

    cat $HOME/.zshrc
  fi
elif [ $(command -v bash) ] ; then
  # noop
  echo "shell is probably bash, but will keep existing .bashrc unmodified"
fi
