# General
autoload -U promptinit && promptinit
autoload -U colors && colors

setopt prompt_subst
setopt correct
setopt extendedglob
unsetopt nomatch
unsetopt beep
setopt autocd

# Autocompletion
autoload -U compinit && compinit
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# History
export HISTSIZE=25000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.zsh_history"
export HISTORY_IGNORE="(ls|cd|pwd|exit|cd ..|sic|sic *)"
# Ignore duplicate commands
setopt HIST_IGNORE_ALL_DUPS
# Ignore commands that start with a space
setopt HIST_IGNORE_SPACE
# add commands as they are typed, don't wait until shell exit
setopt INC_APPEND_HISTORY
# share hist between sessions
setopt SHARE_HISTORY
# Complete Search history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
# bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
# bindkey "${terminfo[kcud1]}" down-line-or-beginning-search

# Vim Mode
bindkey -v
export KEYTIMEOUT=1
bindkey '^?' backward-delete-char # backspace working afte command mode
bindkey '^r' history-incremental-search-backward # ctrl-r starts searching history backward

# edit current command in a text editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^X' edit-command-line
