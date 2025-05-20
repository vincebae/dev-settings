#!/bin/bash
# Install dotfiles to proper location by creating symlinks

# install a file or directory by creating a symlink from source_path to target_path
# usage: install <source_path> <target_path>
function install {
    source_path=$1
    target_path=$2

    if [ -L $target_path ]; then
        echo "Delete symlink $target_path"
        rm $target_path
    elif [ -e $target_path ]; then
        echo "Backup $target_path to ${target_path}.bak"
        mv $target_path ${target_path}.bak
    fi

    echo "Symlink $source_path to $target_path"
    ln -s $source_path $target_path
}

config_dir=$HOME/.config
myconfig_dir=$config_dir/myconfig

# create directories
mkdir -p ~/.nvm
mkdir -p $config_dir/tmux

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ZSH_CUSTOM=~/.oh-my-zsh/custom
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use

# install shell configs to $HOME
install $myconfig_dir/dotfiles/bashrc $HOME/.bashrc
install $myconfig_dir/dotfiles/bash_aliases $HOME/.bash_aliases
install $myconfig_dir/dotfiles/zprofile $HOME/.zprofile
install $myconfig_dir/dotfiles/zshrc $HOME/.zshrc
install $myconfig_dir/dotfiles/zsh_aliases $HOME/.zsh_aliases

# install tmux / vim / nvim / yazi configs
install $myconfig_dir/dotfiles/tmux.conf $config_dir/tmux/tmux.conf
install $myconfig_dir/dotfiles/vimrc $HOME/.vimrc
install $myconfig_dir/nvim $config_dir/nvim
install $myconfig_dir/yazi $config_dir/yazi

