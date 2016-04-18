# Copied and modified from the oh-my-zsh theme from daveverwer
# Red server name, green cwd, blue git status

if [ "$(uname)" = "Darwin" ] ; then
  short_hostname()
  {
      hostname -s|cut -d "-" -f 2
  }
  __docker_machine_prompt()
  {
    if [ -n "$DOCKER_MACHINE_NAME" ] ; then
      echo "%{$fg[grey]%}[$DOCKER_MACHINE_NAME]%{$reset_color%}"
    fi
  }
  __chef_prompt()
  {
    if [ -n "$CHEF_ORG" ] && [ "$CHEF_ORG" != "test-joel" ] ; then
      echo "%{$fg[grey]%}{$CHEF_ORG}%{$reset_color%}"
    fi
  }
  PROMPT='%{$fg[magenta]%}$(short_hostname)%{$reset_color%}:%{$fg[blue]%}%3~%B%{$reset_color%}$(__chef_prompt)$(__docker_machine_prompt)$(git_prompt_info)%(!.#.$) '
else
  PROMPT='%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[green]%}%3~%B%{$reset_color%}$(git_prompt_info)%(!.#.$) '
fi

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✓"

ZSH_THEME_GIT_PROMPT_ADDED=""
ZSH_THEME_GIT_PROMPT_MODIFIED=""
ZSH_THEME_GIT_PROMPT_DELETED=""
ZSH_THEME_GIT_PROMPT_RENAMED=""
ZSH_THEME_GIT_PROMPT_UNMERGED=""
ZSH_THEME_GIT_PROMPT_UNTRACKED=""
