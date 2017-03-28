alias ls='ls --color=auto -CF'
alias l='ls'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -Al'
alias grep='grep --colour --devices=skip'
alias rm='rm -v'
alias wk='cd $WK'

alias v='vim'
alias vv='gvim'
alias t='tmux'

alias myip="nc 4.ifcfg.me 23 | grep IPv4 | cut -d' ' -f4"

# Git
alias g='git'
alias gcl='git clone'
alias gs='git status --short'
alias gd='git diff'
alias gds='git diff --staged'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gca='git commit -a --amend -C HEAD'
alias gsta='git stash -u'
alias gsh='git show --pretty=format:"${git_log_normal_format}"'
alias gp='git push'
alias gpu='git pull'
alias gf='git fetch'
alias gb='git branch'
alias gco='git checkout'
alias gm='git merge'
alias grb='git rebase'
alias gl='git log --topo-order --pretty=format:"${git_log_normal_format}"'
alias gls='git log --topo-order --decorate --pretty=oneline --abbrev-commit'
alias glg='git log --topo-order --graph --decorate --pretty=oneline --abbrev-commit --all'
alias gln='git shortlog --summary --numbered'
alias glh='gl --follow -p -- '

# Ruby on Rails
alias rs='bundle exec rails server'
alias rc='bundle exec rails console'
alias rg='bundle exec rails generate'
alias rdc='bundle exec rake db:create'
alias rdd='bundle exec rake db:drop'
alias rdm='bundle exec rake db:migrate'
alias rds='bundle exec rake db:seed'
alias rbi='bundle install'
alias rbe='bundle exec'

# Docker and Docker Compose
alias d='docker'
alias ds='docker start'
alias dst='docker stop'
alias dps='docker ps'
alias drac='docker rm -f `docker ps --no-trunc -aq`'
alias dc='docker-compose'

# Arch Linux
alias pacins="pacaur -S"
alias pacupd="pacaur --noedit -Syu; pkill -RTMIN+3 i3blocks"
