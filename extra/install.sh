#!/usr/bin/bash

# Basic Tools
sudo apt update
sudo apt install build-essential curl wget xclip vim tmux git i3 ripgrep

# Python3
sudo apt install python3 python3-pip

# JDK 17
sudo apt install openjdk-17-jdk

# Node / Typescript
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install --lts
npm install -g typescript ts-node tslib @types/node
npm install -g prettier eslint

# Scala
curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > cs && chmod +x cs && ./cs setup

# Haskell
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
sudo apt install libicu-dev libncurses-dev libgmp-dev zlib1g-dev
cabal install stylish-haskell
stylish-haskell --defaults > ~/.config/.stylish-haskell.yaml

# NVIM
git clone https://luajit.org/git/luajit.git ~/Downloads/luajit && sudo make install -C ~/Downloads/luajit
sudo ln -sf luajit-2.1.0-beta3 /usr/local/bin/luajit
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb -P ~/Downloads && sudo apt install ~/Downloads/nvim-linux64.deb
sudo ln -sf /usr/bin/nvim /usr/bin/vi
git clone --depth 1 https://github.com/vincebae/bootstrap ~/.config/nvim
