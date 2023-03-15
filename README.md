# My Linux Bootstrap

* Mostly for nvim configuration (~/.config/nvim)
* extra configs in extra/ directory

## Installs

### Basic Tools
* `sudo apt update && apt install build-essential curl wget xclip vim tmux git i3`
* `wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && sudo apt install ./nvim-linux64.deb`
* `git clone --depth 1 https://github.com/vincebae/bootstrap ~/.config/nvim`

### Development Tools

#### Python3
* `sudo apt install python3 python3-pip`

#### JDK 17
* `sudo apt install openjdk-17-jdk`

#### Node / Typescript
* `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash`
* `nvm install --lts`
* `npm install -g typescript ts-node tslib @types/node`
* `npm install -g prettier eslint`

#### Scala
* `curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > cs && chmod +x cs && ./cs setup`

#### Haskell
* `curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh`
* `sudo apt install libicu-dev libncurses-dev libgmp-dev zlib1g-dev`
* `cabal install stylish-haskell`
* `stylish-haskell --defaults > ~/.config/.stylish-haskell.yaml`


