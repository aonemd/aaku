enter_to_repeat() {
  # check if buffer is empty
  if [ ${#${(z)BUFFER}} -eq 0 ]; then
    # get recent command in history and run it
    BUFFER=$history[$((HISTCMD-1))]
  fi
  # accept-line is the default function
  zle accept-line
}

# bind function to enter
zle -N enter_to_repeat
bindkey '^M' enter_to_repeat
