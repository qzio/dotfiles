#!/usr/bin/env bash

if [ -f $NVM_DIR/nvm.sh ] ; then
  alias nvminit="source $NVM_DIR/nvm.sh"

  ___node_cmds=()

  for b in $(ls $NVM_DIR/versions/node/*/bin/) ; do
    [ -d $b ] && continue
    ___node_cmds+="$b"
  done
  for b in $(ls $HOME/.yarn/bin) ; do
    [ -d $b ] && continue
    ___node_cmds+="$b"
  done

  ___nvm_init()
  {
    for c in $___node_cmds ; do unalias $c ; done
    source $NVM_DIR/nvm.sh
    unset __node_cmds
    unset -f ___nvm_init
  }
  for c in $___node_cmds ; do
    alias $c='___nvm_init &&'$c
  done

elif [ -f /usr/local/opt/nvm/nvm.sh ] ; then
  alias nvminit="source /usr/local/opt/nvm/nvm.sh"
fi

