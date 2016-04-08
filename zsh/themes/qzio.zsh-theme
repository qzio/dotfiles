# Copied and modified from the oh-my-zsh theme from daveverwer
# Red server name, green cwd, blue git status

if [ "$(uname)" = "Darwin" ] ; then
  short_hostname()
  {
      hostname -s|cut -d "-" -f 2
  }
  PROMPT='%{$fg[magenta]%}$(short_hostname)%{$reset_color%}:%{$fg[blue]%}%3~%B%{$reset_color%}$(git_prompt_info)%(!.#.$) '
else
  PROMPT='%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%3~%B%{$reset_color%}$(git_prompt_info)%(!.#.$) '
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[grey]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✗%{$fg[grey]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✓%{$fg[grey]%}"

ZSH_THEME_GIT_PROMPT_ADDED=""
ZSH_THEME_GIT_PROMPT_MODIFIED=""
ZSH_THEME_GIT_PROMPT_DELETED=""
ZSH_THEME_GIT_PROMPT_RENAMED=""
ZSH_THEME_GIT_PROMPT_UNMERGED=""
ZSH_THEME_GIT_PROMPT_UNTRACKED=""
