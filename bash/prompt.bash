sys_type=`uname`

if [ "$sys_type" == "Darwin" ]; then
  PS1='\[\033[01;32m\]\u@\h:\[\033[01;34m\]\W'
  PS1=$PS1'\[\033[00m\]'
  if [ -f ~/.git-prompt.sh ] ; then
    export GIT_PS1_SHOWDIRTYSTATE=1
    . ~/.git-prompt.sh
    PS1=$PS1'$(__git_ps1 " (%s)")'
  fi
  if [ "`id -u`" -eq 0 ]; then
   PS1=$PS1'# '
  else
    PS1=$PS1'$ '
  fi
else
  PS1='\[\033[01;32m\]\u@\h:\[\033[01;34m\]\W'
  PS1=$PS1'\[\033[00;93m\]$(__git_ps1)\[\033[00m\]' # add git branch name
  if [ "`id -u`" -eq 0 ]; then
   PS1=$PS1'# '
  else
    PS1=$PS1'$ '
  fi
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
fi
export PS1
