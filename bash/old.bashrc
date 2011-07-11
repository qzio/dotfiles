# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
   debian_chroot=$(cat /etc/debian_chroot)
fi

export TERM=xterm-256color
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
   xterm-color) color_prompt=yes;;
   xterm-256color) color_prompt=yes;;
esac

# bash_completion is needed before git_branch is defined
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
   . /etc/bash_completion
fi
# fancy git prompt stuff.
git_branch() {
	Color_Off='\033[0m'       # Text Reset
	Red='\033[0;31m'          # Red
	IYellow='\033[0;93m'      # Yellow
  if [ "$(__git_ps1 '%s')" = "master" ]; then
    gc="${Red}$(__git_ps1 '(%s)')${Color_Off}"
  else
    gc="${IYellow}$(__git_ps1 '(%s)')${Color_Off}"
  fi
	gc="$(__git_ps1)"
  echo -e "$gc\[\033[00m"
}


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
   if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      # We have color support; assume it's compliant with Ecma-48
      # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
      # a case would tend to support setf rather than setaf.)
      color_prompt=yes
   else
      color_prompt=
   fi
fi

if [ "$color_prompt" = yes ]; then
	 PS1='\[\033[01;32m\]\u@\h:\[\033[01;34m\]\W'
	 PS1=$PS1'\[\033[00;93m\]$(__git_ps1)\[\033[00m\]'
   if [ "`id -u`" -eq 0 ]; then
		 PS1=$PS1'# '
	 else
      PS1=$PS1'$ '
   fi
else
   PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
   xterm*|rxvt*)
   PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
   ;;
   *)
   ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
   alias ls='ls --color=auto'
   #alias dir='dir --color=auto'
   #alias vdir='vdir --color=auto'

   alias grep='grep --color=auto --exclude=tags'
   alias fgrep='fgrep --color=auto'
   alias egrep='egrep --color=auto'
   alias phpunit='phpunit --colors'
fi
alias cdrubylib='cd /usr/lib/ruby/gems/1.8/gems'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
   . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
export PATH=$PATH:/sbin:/usr/sbin:/var/lib/gems/1.8/bin:~/bin:/home/joel/android/android-sdk-linux_86/tools:~/local/node/bin
export GREP_OPTIONS='--color=auto'
export VISUAL=vim
alias spec='spec -c -f specdoc'
if [ -f ~/.rake_bash_autocomplete.sh ]; then
   source ~/.rake_bash_autocomplete.sh
fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

if [ -f ~/.flattr_extras ]; then
   source ~/.flattr_extras
fi
if [ -f ~/dotfiles/aliases.bash ]; then
   source ~/dotfiles/aliases.bash
fi

#export NODE_PATH='.,/home/qzio/locale/node'
