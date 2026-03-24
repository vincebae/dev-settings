# My Dev Settings

* Dotfiles
* Neovim configs
* Some useful git-hooks and scripts
* Programming langauges and tools

## HOWTO
```
$ git clone --depth 1 https://github.com/vincebae/dev-settings $HOME/.config/myconfig
$ cd $HOME/.config/myconfig

$ ./install_1_zsh.sh       # Install oh-my-zsh and plugins. need curl and git
$ ./install_2_dotfiles.sh  # Install dotfiles and nvim configs
$ ./install_3_homebrew.sh  # Install homebrew to install other tools.

$ chsh -s $(which zsh)     # Change the default shell to zsh if not already. Need re-log in.

# Re-log in if default shell is changed.
# Otherwise, just restart the terminal or shell.

$ ./install_4_tools.sh     # Install basic tools and programming languages.

$ nvm install --lts      # Install nvm somehow not working inside shell script
$ ./install_4_ts.sh        # Install Node / TS tools

$ gh auth login          # Login to github. Need repo key.
```

## Tmux plugins
* In Tmux, `prefix` - `I` to install plugins if not properly installed
