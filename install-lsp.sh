#!/usr/bin/env zsh

GO111MODULE=on go get golang.org/x/tools/gopls@latest
npm install -g typescript-language-server
pacman -S clang
gem install solargraph
