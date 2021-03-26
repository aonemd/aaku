ts() {
  [ -z "$1" ] && return

  local session_path=""
  case "$1" in
    .)
      session_path=$(pwd)
      ;;
    *)
      session_path="${1}"
  esac

  local raw_session_name="${session_path##*/}"
  local session_name="${raw_session_name//[.]/-}"

  if tmux has-session -t="${session_name}" 2> /dev/null; then
    tmux attach -t "${session_name}"
    return
  fi

  pushd "${session_path}" > /dev/null

  tmux new-session   -d -s "${session_name}"

  tmux send-keys     -t="${session_name}":1 'vim ' C-m
  sleep 0.5
  tmux split-window  -t="${session_name}":1 -v
  tmux resize-pane   -t="${session_name}":1 -D 15
  tmux select-pane   -t="${session_name}":1.1

  tmux new-window    -t="${session_name}":2 -n 'log'
  tmux new-window    -t="${session_name}":3 -n 'misc'

  tmux select-window -t="${session_name}":1
  [ -n "$TMUX" ] && tmux switch -t="${session_name}" || tmux attach -t="${session_name}"

  popd > /dev/null
}
