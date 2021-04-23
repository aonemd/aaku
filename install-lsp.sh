#!/usr/bin/env zsh

pacman -S clang
npm install -g typescript typescript-language-server
npm install -g vim-language-server
GO111MODULE=on go get golang.org/x/tools/gopls@latest
gem install solargraph
