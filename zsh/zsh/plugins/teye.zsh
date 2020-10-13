teye() {
  local session_name="news"

  if tmux has-session -t "${session_name}" 2> /dev/null; then
    tmux attach -t "${session_name}"
    return
  fi

  tmux new-session   -d -s "${session_name}"

  tmux split-window  -t "${session_name}":1 -v
  tmux split-window  -t "${session_name}":1.2 -h

  tmux send-keys     -t "${session_name}":1.1 'newsboat ' C-m
  tmux send-keys     -t "${session_name}":1.2 'sysupdates ' C-m
  tmux send-keys     -t "${session_name}":1.3 'weather ' C-m

  tmux new-window    -t "${session_name}":2 -n 'tasks'
  tmux send-keys     -t "${session_name}":2 'nin l ' C-m

  tmux new-window    -t "${session_name}":3 -n 'web'
  tmux send-keys     -t "${session_name}":3 'w3m https://duckduckgo.com' C-m

  tmux select-pane   -t "${session_name}":1.1
  tmux select-window -t "${session_name}":1

  [ -n "$TMUX" ] && tmux switch -t "${session_name}" || tmux attach -t "${session_name}"
}
