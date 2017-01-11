# aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias wk='cd $WK'

alias v='vim'
alias vv='gvim'
alias t='tmux'

alias myip="nc 4.ifcfg.me 23 | grep IPv4 | cut -d' ' -f4"

# Git
alias g='git'
alias gcl='git clone'
alias gs='git status --short'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gp='git push'
alias gpu='git pull'
alias gf='git fetch'
alias gb='git branch'
alias gco='git checkout'
alias gm='git merge'
alias gd='git diff'
alias gl='git log --topo-order --pretty=format:"${git_log_normal_format}"'
alias gls='git log --topo-order --pretty=format:"${git_log_simple_format}"'
alias glg='git log --topo-order --all --graph --pretty=format:"${git_log_graph_format}"'
alias gln='git shortlog --summary --numbered'
alias glh='git log --follow -p --'

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
alias dps='docker ps -a'
alias drac='docker rm -f `docker ps --no-trunc -aq`'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcs='docker-compose start'
alias dcst='docker-compose stop'
