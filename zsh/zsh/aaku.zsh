# General
autoload -U promptinit && promptinit
autoload -U colors && colors

setopt prompt_subst
setopt correct
setopt extendedglob
setopt glob_dots
unsetopt beep
setopt autocd

# Autocompletion
autoload -U compinit && compinit
setopt menu_complete
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# History
export HISTSIZE=25000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.zsh_history"
export HISTORY_IGNORE="(ls|cd|pwd|exit|cd ..)"
setopt HIST_IGNORE_ALL_DUPS   # Ignore duplicate commands
setopt HIST_IGNORE_SPACE 	    # Ignore commands that start with a space
setopt INC_APPEND_HISTORY     # add commands as they are typed, don't wait until shell exit
setopt SHARE_HISTORY          # share hist between sessions
# Complete Search history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Vim Mode
bindkey -v
export KEYTIMEOUT=1
bindkey '^?' backward-delete-char # backspace working afte command mode
bindkey '^r' history-incremental-search-backward # ctrl-r starts searching history backward
