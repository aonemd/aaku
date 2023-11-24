export NVM_DIR="$HOME/.nvm"
export PATH="$PATH:$HOME/.yarn/bin"

include $NVM_DIR/nvm.sh --no-use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use --lts
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc


# # lazy load nvm
# nvm() {
#   unset -f nvm
#   include $NVM_DIR/nvm.sh --no-use
#   nvm $@
# }
