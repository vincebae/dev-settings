#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ZSH_CUSTOM=~/.oh-my-zsh/custom
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
git clone https://github.com/joshskidmore/zsh-fzf-history-search \
    ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
