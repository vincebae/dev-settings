# My Mac / Linux Dev Settings

* Mostly for nvim configuration (~/.config/nvim).
* extra configs located in extra/ directory.

## Essentials

### Prerequisite (Linux)
```
sudo apt update
sudo apt upgrade
sudo apt install build-essential procps curl file git zsh guake tilda colorized-logs
```

### Oh-My-Zsh
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### Install Homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# On Mac
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew/shellenv)"

# On Linux
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc
```

### Basic tools
```
brew install wget xclip xsel vim nvim tmux git python3 ripgrep fzf tldr

# On Mac
brew install --cask iterm2
```

### Tmux
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
* (In tmux) `<prefix>` I (caplital) to install plugins

### Npm
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.zshrc
nvm install --lts
```

### Git
```
brew install gh lazygit
git config --global --edit
gh auth login
```

## Languages

### JDK 21
```
brew install openjdk@21 maven gradle
```

### Clojure
```
brew install clojure leiningen clj-kondo borkdude/brew/babashka
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/weavejester/cljfmt/HEAD/install.sh)"
```
 
### Rust
* `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
* `cargo +stable install papyrus --no-default-features --features="format,runnable"`
* `cargo install rust-script`
* `cargo install evcxr_repl`
* `cargo install --locked bacon`

### Haskell
* `curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh`
* `sudo apt install libicu-dev libncurses-dev libgmp-dev zlib1g-dev`
* `cabal install stylish-haskell`
* `stylish-haskell --defaults > ~/.config/.stylish-haskell.yaml`

### Scala
* `curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > cs && chmod +x cs && ./cs setup`

