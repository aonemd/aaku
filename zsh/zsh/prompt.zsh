function git_status {
  if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]]; then
    echo "%{$fg[red]%}"
  else
    echo "%{$fg[green]%}"
  fi
}

function git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ $(git_status)\1/"
}

function hg_status {
  if [[ $( hg status 2> /dev/null ) != "" ]]; then
    echo "%{$fg[red]%}"
  else
    echo "%{$fg[green]%}"
  fi
}

function hg_branch {
  hg branch 2> /dev/null | sed -e "s/\(.*\)/ $(hg_status)\1/"
}

PROMPT='%{$fg[blue]%}%1~$(git_branch)$(hg_branch) %{$reset_color%}➜ '
