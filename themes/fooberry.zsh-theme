#!/bin/zsh

local user_prompt='%{$terminfo[bold]$fg[blue]%}%n%{$reset_color%}'
local host_prompt='%{$terminfo[bold]$fg[black]%}at %{$FG[208]%}%m%{$reset_color%}'
local pwd_prompt='%{$terminfo[bold]$fg[black]%}in %{$fg[green]%}%~%{$reset_color%}'
PROMPT="$user_prompt $host_prompt ${pwd_prompt}"

local git_branch='$(git_prompt_info)$(git_remote_status)%{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$terminfo[bold]$fg[black]%}on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$FG[088]%}▼"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$FG[214]%}▲"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$FG[226]%}⧓"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=""

git_mode() {
  local repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if [[ -e "$repo_path/BISECT_LOG" ]]; then
    echo -e " %{$fg[yellow]%}bisecting"
  elif [[ -e "$repo_path/MERGE_HEAD" ]]; then
    echo -e " %{$fg[yellow]%}mergeing"
  elif [[ -e "$repo_path/rebase" || -e "$repo_path/rebase-apply" || -e "$repo_path/rebase-merge" || -e "$repo_path/../.dotest" ]]; then
    echo -e " %{$fg[yellow]%}rebasing"
  fi
}
PROMPT+="${git_branch}${git_mode}"

ruby_prompt_info(){
  local ruby_version="r$(ruby -v | cut -f 2 -d ' ' | sed s/p.*//)"
  echo -e "%{$terminfo[bold]$fg[black]%}w/ %{$fg[red]%}${ruby_version}%{$reset_color%}"
}
[[ "${ZSH_THEME_RUBY_VERSION:-Y}" = "Y" ]]  && PROMPT+=' $(ruby_prompt_info)'

node_prompt_info(){
    local node_version="$(node -v | sed s/v/n/)"
    echo -e "%{$fg[yellow]%}${node_version}%{$reset_color%}"
}

which -s node > /dev/null
[[ "${ZSH_THEME_NODE_VERSION:-Y}" = "Y" && "$?" -eq 0 ]]  && PROMPT+=' $(node_prompt_info)'

personal_prompt_things() {}

PROMPT+='$(personal_prompt_things)'

local return_code='%{$terminfo[bold]%}%(?,%{$fg[black]%},%{$fg[red]%})'

PROMPT+="
${return_code}$ %{$reset_color%}"

