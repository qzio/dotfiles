#!/bin/sh

function parse_git_branch {
  git branch 2>/dev/null | sed -n '/^\* \(.*\)/s//(\1)/p'
}

function amend_prompt_with_git {
  local p q='$(parse_git_branch)' r

  if [[ $TERM = @(xterm-color|xterm|screen*) ]]; then
    if [[ ${PS1:1:1} = $'\r' ]]; then
      p=${PS1:0:1}
    else
      p=$'\001'
      PS1=$p$'\r'$PS1
    fi
    q=$p$'\e[1;33m'$p$q$p$'\e[0m'$p
  fi

  p=${PS1%%*( )[#$]*( )}
  if [[ $p != "$PS1" ]]; then
    # prompt ends with space + #-or-$ + space, we can amend
    r=${PS1: ${#p}}
    PS1=$p$q$r
  fi
}
amend_prompt_with_git
unset -f amend_prompt_with_git
