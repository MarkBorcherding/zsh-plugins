#!/bin/zsh

local user_prompt='%{$terminfo[bold]$fg[blue]%}%n%{$reset_color%}'
local host_prompt='%{$terminfo[bold]$fg[black]%}at %{$FG[208]%}%m%{$reset_color%}'
local pwd_prompt='%{$terminfo[bold]$fg[black]%}in %{$fg[green]%}%~%{$reset_color%}'

local git_branch='$(git_prompt_info)%{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$terminfo[bold]$fg[black]%}on %{$fg[magenta]%}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

local ruby_version="$(ruby -v | awk '{ print $1 " " $2 }')"
local ruby_prompt='%{$terminfo[bold]$fg[black]%}w/ %{$fg[red]%}${ruby_version}%{$reset_color%}'

local virtualenv_prompt='$(virtualenv_prompt_info)'
virtualenv_prompt_info(){
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # Strip out the path and just leave the env name
    venv="${VIRTUAL_ENV##*/}"
    echo -e " %{$terminfo[bold]$fg[black]%}working on %{$FG[64]%}${venv}%{$reset_color%}"
  fi
}

local return_code='%{$terminfo[bold]%}%(?,%{$fg[black]%},%{$fg[red]%})'

PROMPT="$user_prompt $host_prompt ${pwd_prompt}${git_branch}${virtualenv_prompt}
${return_code}$ %{$reset_color%} "
