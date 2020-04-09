#!/usr/bin/env bash

echo "install-dein.sh"
echo "install-misc.sh"
echo "install-nvm.sh"
(./install-dein.sh) &
(./install-misc.sh) &
(./install-nvm.sh) &

(set -x
mkdir -p $HOME/bin/
ln -sf $HOME/dotfiles/snippets/keymap_switcher.sh $HOME/bin
ln -sf $HOME/dotfiles/snippets/re-attach-ssh-agent.sh $HOME/bin
ln -sf $HOME/dotfiles/snippets/urxvt-change-font.sh $HOME/bin/changefont
ln -sf $HOME/dotfiles/snippets/pass-gen $HOME/bin/
ln -sf $HOME/dotfiles/snippets/copy $HOME/bin/
)
if [ ! -f $HOME/.shell_extras ] ; then
  echo "# -- generated " > $HOME/.shell_extras
  echo "export NVM_BIN=\$HOME/.nvm/versions/node/v10.20.0/bin" >> $HOME/.shell_extras
  echo "PATH=\$PATH:\$NVM_BIN" >> $HOME/.shell_extras
  echo "export EDITOR=nvim" >> $HOME/.shell_extras
fi

wait
echo "nice, now nvm ls-remote |grep v10 and install the latest, configure ~/.shell_extras afterwards!"
echo "and don't forget to npm install -g typescript neovim yarn eslint!"
