#!/bin/bash
alias cdflattr='cd ~/Private/flattr/projects/flattr'
alias fmysql='ssh -t flattr.local mysql -uroot flattr'
alias flog='ssh -t flattr.local sudo multitail /var/log/syslog'
function vimflattr()
{
  if [ -f ".lvimrc" ]; then
    vim -S .lvimrc
  else
    vim
  fi
}
