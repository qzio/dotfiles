#!/usr/bin/env bash

if [ -f $NVM_DIR/nvm.sh ] ; then
  alias nvminit="source $NVM_DIR/nvm.sh"
elif [ -f /usr/local/opt/nvm/nvm.sh ] ; then
  alias nvminit="source /usr/local/opt/nvm/nvm.sh"
else
  nvminit() {
    echo "nvm can't be found"
  }
fi

