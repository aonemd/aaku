# Based on: https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

ffw() {
  if [[ $# -eq 1 ]]; then
    selected=$1
  else
    selected=$(find ~/workspace/ -mindepth 1 -maxdepth 1 -type d | fzf)
  fi

  if [[ -z $selected ]]; then
    exit 0
  fi

  tx $selected
}
