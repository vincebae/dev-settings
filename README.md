# My Dev Settings

* Dotfiles
* Neovim configs
* Some useful git-hooks and scripts
* Programming langauges and tools

## HOWTO
```
$ git clone --depth 1 https://github.com/vincebae/bootstrap $HOME/.config/myconfig
$ cd $HOME/.config/myconfig
$ ./install_zsh.sh       # Install oh-my-zsh and plugins. need curl and git
$ ./install_dotfiles.sh  # Install dotfiles and nvim configs
$ ./install_tools.sh     # Install basic tools and programming languages.
$ chsh -s $(which zsh)   # Change the default shell to zsh. Need re-log in.
$ nvm install --lts      # Install nvm somehow not working inside shell script
$ ./install_ts.sh        # Install Node / TS tools
```

## Tmux plugins
* In Tmux, `prefix` - `I` to install plugins if not properly installed
