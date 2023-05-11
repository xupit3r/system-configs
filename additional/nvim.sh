#!/bin/zsh

# install python stuffs
pip3 install neovim --upgrade

# install ruby stuffs
gem install neovim

# install nodejs stuffs
sudo npm i -g neovim emmet typescript-language-server typescript @volar/vue-language-server

# some pakages
sudo pacman -Syu ripgrep fd luarocks wget curl
