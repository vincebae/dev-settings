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
$ ./install_3_tools.sh     # Install basic tools and programming languages.

$ chsh -s $(which zsh)   # Change the default shell to zsh. Need re-log in.

$ nvm install --lts      # Install nvm somehow not working inside shell script
$ ./install_4_ts.sh        # Install Node / TS tools

$ gh auth login          # Login to github. Need repo key.
```

## Tmux plugins
* In Tmux, `prefix` - `I` to install plugins if not properly installed
