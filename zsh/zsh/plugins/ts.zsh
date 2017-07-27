ts () {
  [ -z "$1" ] && return

  local session_path="${1}"
  local session_name="${1##*/}"

  if tmux has-session -t "${session_name}" 2> /dev/null; then
    tmux attach -t "${session_name}"
    return
  fi

  pushd "${WK}/${session_path}"

  tmux new-session   -d -s "${session_name}"
  tmux split-window  -v
  tmux split-window  -h
  tmux resize-pane   -D 17
  tmux select-pane   -t 0
  tmux send-keys     'vim ' C-m

  tmux new-window    -t "${session_name}":2 -n 'log'
  tmux new-window    -t "${session_name}":3 -n 'misc'

  tmux select-window -t 1
  tmux attach        -t "${session_name}"

  popd
}
