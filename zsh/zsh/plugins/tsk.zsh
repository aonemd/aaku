tsk() {
  args=$@
  tmux send-keys -t 2 "$args" C-m
}
