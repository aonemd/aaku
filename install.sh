#!/usr/bin/env zsh

BASEDIR="$(cd "$(dirname "${ZSH_SOURCE[0]}")" && pwd)"

echo "Updating submodules..."
git submodule update --init --recursive --remote

echo "Linking files..."
ln -sfn ${BASEDIR}/vim/vim/ $HOME/.vim
ln -sfn ${BASEDIR}/vim/vimrc $HOME/.vimrc
ln -sfn ${BASEDIR}/vim/gvimrc $HOME/.gvimrc

ln -sfn ${BASEDIR}/zsh/zsh/ $HOME/.zsh
ln -sfn ${BASEDIR}/zsh/zprofile $HOME/.zprofile
ln -sfn ${BASEDIR}/zsh/zshenv $HOME/.zshenv
ln -sfn ${BASEDIR}/zsh/zshrc $HOME/.zshrc

ln -sfn ${BASEDIR}/tmux/tmux.conf $HOME/.tmux.conf

ln -sfn ${BASEDIR}/app-config/gitconfig $HOME/.gitconfig
ln -sfn ${BASEDIR}/app-config/irbrc $HOME/.irbrc
ln -sfn ${BASEDIR}/app-config/agignore $HOME/.agignore
ln -sfn ${BASEDIR}/app-config/fehbg $HOME/.fehbg

[ -d $HOME/.config/termite/ ] || mkdir -p $HOME/.config/termite
ln -sfnr ${BASEDIR}/app-config/termite $HOME/.config/termite/config

[ -d $HOME/.config/rofi/ ] || mkdir -p $HOME/.config/rofi
ln -sfnr ${BASEDIR}/app-config/rofi $HOME/.config/rofi/config

[ -d $HOME/.config/dunst/ ] || mkdir -p $HOME/.config/dunst
ln -sfnr ${BASEDIR}/app-config/dunstrc $HOME/.config/dunst/dunstrc

[ -d $HOME/.config/compton/ ] || mkdir -p $HOME/.config/compton
ln -sfnr ${BASEDIR}/app-config/compton.conf $HOME/.config/compton/compton.conf

[ -d $HOME/.config/cmus/ ] || mkdir -p $HOME/.config/cmus
ln -sfnr ${BASEDIR}/app-config/cmus-theme $HOME/.config/cmus/aaku.theme

[ -d $HOME/.irssi ] || mkdir -p $HOME/.irssi
ln -sfnr ${BASEDIR}/app-config/irssi/config $HOME/.irssi/config
ln -sfnr ${BASEDIR}/app-config/irssi/weed.theme $HOME/.irssi/weed.theme
ln -sfnr ${BASEDIR}/app-config/irssi/scripts $HOME/.irssi/scripts

ln -sfnr ${BASEDIR}/app-config/Xresources $HOME/.Xresources

[ -d $HOME/.config/i3/ ] || mkdir -p $HOME/.config/i3
ln -sfnr ${BASEDIR}/i3/config $HOME/.config/i3/config
ln -sfnr ${BASEDIR}/i3/i3status.conf $HOME/.config/i3/i3status.conf
ln -sfnr ${BASEDIR}/i3/i3blocks.conf $HOME/.config/i3/i3blocks.conf
ln -sfnr ${BASEDIR}/i3/scripts $HOME/.config/i3/scripts
ln -sfnr ${BASEDIR}/i3/blocklets $HOME/.config/i3/blocklets
ln -sfnr ${BASEDIR}/i3/dep/xinitrc $HOME/.xinitrc

echo "Installing Vim plugins ..."
echo | vim - +PlugInstall +qall

echo "Source Zsh files"
source $HOME/.zshrc

[ -d $HOME/Workspace/fonts/ ] && exit
echo "Installing Fonts..."
git clone https://github.com/powerline/fonts.git $HOME/Workspace/fonts/
pushd $HOME/Workspace/fonts && ./install.sh && popd

git clone https://github.com/sebastiencs/icons-in-terminal.git $HOME/Workspace/fonts/icons-in-terminal
pushd $HOME/Workspace/fonts/icons-in-terminal && ./install.sh && popd