PROMPT_INSERT_SYMBOL="›"

function prompt_current_dir {
  echo -n "%{$fg[blue]%}%1~"
}

function prompt_symbol {
  local current_symbol="$PROMPT_INSERT_SYMBOL"
  echo -n "%{$fg[white]%}$current_symbol"
}

function git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ $(git_status)\1/"
}

function git_status {
  if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]]; then
    echo "%{$fg[red]%}"
  else
    echo "%{$fg[green]%}"
  fi
}

function hg_branch {
  hg branch 2> /dev/null | sed -e "s/\(.*\)/ $(hg_status)\1/"
}

function hg_status {
  if [[ $( hg status 2> /dev/null ) != "" ]]; then
    echo "%{$fg[red]%}"
  else
    echo "%{$fg[green]%}"
  fi
}

PROMPT='$(prompt_current_dir)$(git_branch)$(hg_branch) $(prompt_symbol) %{$reset_color%}'
