#!/usr/bin/env zsh

BASEDIR="$(cd "$(dirname "${ZSH_SOURCE[0]}")" && pwd)"

echo "Updating submodules..."
git submodule update --init --recursive --remote

echo "Linking files..."
ln -sfn ${BASEDIR}/vim/vim $HOME/.vim
ln -sfn ${BASEDIR}/vim/vimrc $HOME/.vimrc
ln -sfn ${BASEDIR}/vim/gvimrc $HOME/.gvimrc

ln -sfn ${BASEDIR}/zsh/zsh $HOME/.zsh
ln -sfn ${BASEDIR}/zsh/zprofile $HOME/.zprofile
ln -sfn ${BASEDIR}/zsh/zshenv $HOME/.zshenv
ln -sfn ${BASEDIR}/zsh/zshrc $HOME/.zshrc

ln -sfn ${BASEDIR}/tmux/tmux.conf $HOME/.tmux.conf
ln -sfn ${BASEDIR}/git/gitconfig $HOME/.gitconfig
ln -sfn ${BASEDIR}/git/gitignore $HOME/.gitignore
ln -sfn ${BASEDIR}/ruby/irbrc $HOME/.irbrc
ln -sfn ${BASEDIR}/scheme/csirc $HOME/.csirc
ln -sfn ${BASEDIR}/rg/rgignore $HOME/.rgignore

[ -d $HOME/.config/cmus/ ] || mkdir -p $HOME/.config/cmus
ln -sfn ${BASEDIR}/cmus/aaku.theme $HOME/.config/cmus/aaku.theme
ln -sfn ${BASEDIR}/cmus/rc $HOME/.config/cmus/rc

[ -d $HOME/.irssi ] || mkdir -p $HOME/.irssi
ln -sfn ${BASEDIR}/irssi/config $HOME/.irssi/config
ln -sfn ${BASEDIR}/irssi/weed.theme $HOME/.irssi/weed.theme
ln -sfn ${BASEDIR}/irssi/scripts $HOME/.irssi/scripts

[ -d $HOME/.newsboat/ ] || mkdir -p $HOME/.newsboat
ln -sfn ${BASEDIR}/newsboat/config $HOME/.newsboat/config
ln -sfn ${BASEDIR}/newsboat/urls $HOME/.newsboat/urls

ln -sfn ${BASEDIR}/X11/xinitrc $HOME/.xinitrc
ln -sfn ${BASEDIR}/X11/Xresources $HOME/.Xresources

ln -sfn ${BASEDIR}/bin/fehbg $HOME/.fehbg

[ -d $HOME/.config/termite/ ] || mkdir -p $HOME/.config/termite
ln -sfn ${BASEDIR}/termite/config $HOME/.config/termite/config

[ -d $HOME/.config/rofi/ ] || mkdir -p $HOME/.config/rofi
ln -sfn ${BASEDIR}/rofi/config $HOME/.config/rofi/config

[ -d $HOME/.config/dunst/ ] || mkdir -p $HOME/.config/dunst
ln -sfn ${BASEDIR}/dunst/dunstrc $HOME/.config/dunst/dunstrc

[ -d $HOME/.config/compton/ ] || mkdir -p $HOME/.config/compton
ln -sfn ${BASEDIR}/compton/compton.conf $HOME/.config/compton/compton.conf

ln -sfn ${BASEDIR}/fontconfig $HOME/.config/fontconfig

echo "Installing Vim plugins..."
vim -E -c PlugInstall  -c qall
vim -c 'CocInstall -sync coc-go coc-tsserver coc-html coc-css coc-emmet coc-solargraph|q'

echo "Source Zsh files"
source $HOME/.zshrc

mkdir $HOME/Workspace

[ -d $HOME/Workspace/fonts/ ] && exit
echo "Installing Fonts..."
git clone https://github.com/powerline/fonts.git $HOME/Workspace/fonts/
pushd $HOME/Workspace/fonts && ./install.sh && popd

git clone https://github.com/sebastiencs/icons-in-terminal.git $HOME/Workspace/fonts/icons-in-terminal
pushd $HOME/Workspace/fonts/icons-in-terminal && ./install.sh && popd
