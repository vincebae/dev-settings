#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then  # Linux
    echo "Installing for Linux..."
    sudo apt update
    sudo apt upgrade
    sudo apt install build-essential procps curl file zsh colorized-logs

    # Install homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ "$OSTYPE" == "darwin"* ]]; then  # Mac OSX
    echo "Installing for Mac OSX..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Basic tools
brew install wget xclip xsel vim nvim tmux git ripgrep fzf fzy tldr fd jq yq lazygit \
    fortune cowsay yazi tree-sitter bat gh

# Programming Languages and Tools
brew install python openjdk jdtls nvm clojure cljfmt clj-kondo borkdude/brew/babashka

# Install Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
~/.config/tmux/plugins/tpm/scripts/install_plugins.sh

# Set up github account
git config --global user.email "vincebae@gmail.com"
git config --global user.name  "Seung-Bin Bae"
