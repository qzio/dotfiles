# Copied and modified from the oh-my-zsh theme from daveverwer
# Red server name, green cwd, blue git status

#PROMPT='%{$fg[cyan]%}%m%{$reset_color%}:%{$fg[green]%}%3~ %B%{$reset_color%}$(git_prompt_info) %(!.#.$) '
PROMPT='%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[green]%}%3~%B%{$reset_color%}$(git_prompt_info) %(!.#.$) '

#ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[blue]%}("
#ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED=""
ZSH_THEME_GIT_PROMPT_MODIFIED=""
ZSH_THEME_GIT_PROMPT_DELETED=""
ZSH_THEME_GIT_PROMPT_RENAMED=""
ZSH_THEME_GIT_PROMPT_UNMERGED=""
ZSH_THEME_GIT_PROMPT_UNTRACKED=""
