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

  tmux send-keys     -t "${session_name}":1 'vim ' C-m
  tmux split-window  -t "${session_name}":1 -v
  tmux split-window  -t "${session_name}":1 -h
  tmux resize-pane   -t "${session_name}":1 -D 17
  tmux select-pane   -t "${session_name}":1.0

  tmux new-window    -t "${session_name}":2 -n 'log'
  tmux new-window    -t "${session_name}":3 -n 'misc'

  tmux select-window -t "${session_name}":1
  [ -n "$TMUX" ] && tmux switch -t "${session_name}" || tmux attach -t "${session_name}"

  popd
}
