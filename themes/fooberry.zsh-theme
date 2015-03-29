#!/bin/zsh

local user_prompt='%{$terminfo[bold]$fg[blue]%}%n%{$reset_color%}'
local host_prompt='%{$terminfo[bold]$fg[black]%}at %{$FG[208]%}%m%{$reset_color%}'
local pwd_prompt='%{$terminfo[bold]$fg[black]%}in %{$fg[green]%}%~%{$reset_color%}'

local git_branch='$(git_prompt_info)$(git_remote_status)%{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$terminfo[bold]$fg[black]%}on %{$fg[magenta]%}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$FG[088]%}▼"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$FG[214]%}▲"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$FG[226]%}⧓"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN="⊙"


local ruby_version="$(ruby -v | awk '{ print $1 " " $2 }')"
local ruby_prompt='%{$terminfo[bold]$fg[black]%}w/ %{$fg[red]%}${ruby_version}%{$reset_color%}'

local virtualenv_prompt='$(virtualenv_prompt_info)'
virtualenv_prompt_info(){
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # Strip out the path and just leave the env name
    venv="${VIRTUAL_ENV##*/}"
    echo -e " %{$terminfo[bold]$fg[black]%}working on %{$FG[118]%}${venv}%{$reset_color%}"
  fi
}

local git_mode_prompt='$(git_mode)'
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

local return_code='%{$terminfo[bold]%}%(?,%{$fg[black]%},%{$fg[red]%})'


PROMPT="$user_prompt $host_prompt ${pwd_prompt}${git_branch}${git_mode_prompt}${virtualenv_prompt}
${return_code}$ %{$reset_color%} "
