# My Linux Bootstrap

* Mostly for nvim configuration (~/.config/nvim)
* extra configs in extra/ directory

## Installs

### Basic Tools
* `sudo apt update && apt install curl wget xclip vim tmux git`
* `wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && sudo apt install ./nvim-linux64.deb`
* `git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim`
* `git clone --depth 1 https://github.com/vincebae/bootstrap ~/.config/nvim`

### Development Tools

#### Python3 and JDK 17
* `sudo apt install python3 python3-pip openjdk-17-jdk`

#### Node / Typescript / TS-Node
* `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash`
* `nvm install --lts`
* `npm install -g typescript ts-node tslib @types/node`
* `npm install -g prettier eslint`

#### Scala
* `curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > cs && chmod +x cs && ./cs setup`



