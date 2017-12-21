PROMPT_INSERT_SYMBOL="›"
PROMPT_NORMAL_SYMBOL="·"

function prompt_redraw {
    zle reset-prompt
}
zle -N zle-keymap-select prompt_redraw

function prompt_current_dir {
  echo -n "%{$fg[blue]%}%1~"
}

function prompt_symbol {
  local current_symbol="$PROMPT_INSERT_SYMBOL"
  [ "$KEYMAP" = 'vicmd' ] && current_symbol="$PROMPT_NORMAL_SYMBOL"
  echo -n "%{$fg[white]%}$current_symbol"
}

function prompt_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ $(_prompt_git_status)\1/"
}

function _prompt_git_status {
  if [ -n "$(git status --porcelain 2> /dev/null)" ]; then
    echo "%{$fg[red]%}"
  else
    echo "%{$fg[green]%}"
  fi
}

function prompt_hg_branch {
  hg branch 2> /dev/null | sed -e "s/\(.*\)/ $(_prompt_hg_status)\1/"
}

function _prompt_hg_status {
  if [[ $( hg status 2> /dev/null ) != "" ]]; then
    echo "%{$fg[red]%}"
  else
    echo "%{$fg[green]%}"
  fi
}

PROMPT='$(prompt_current_dir)$(prompt_git_branch)$(prompt_hg_branch) $(prompt_symbol) %{$reset_color%}'
