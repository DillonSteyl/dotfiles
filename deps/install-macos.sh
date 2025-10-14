#!/bin/bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Add brew to path
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install prereq packages
brew install \
	xclip \
	ripgrep \
	fzf \
	stow \
	pipx \
	gnupg \
	neofetch \
	zlib

pipx ensurepath

# Install TMUX
brew install tmux

# Install LAZY packages
brew install jesseduffield/lazygit/lazygit
brew install jesseduffield/lazydocker/lazydocker
brew install git-spice

# Install STARSHIP PROMPT
brew install starship

# Install NVIM
brew install nvim

# Install PYENV
brew install pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

# Install NVM / Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install node

# Install POETRY
source ~/.zshrc
pipx install poetry
mkdir ~/.zfunc
poetry completions zsh > ~/.zfunc/_poetry
echo 'fpath+=~/.zfunc' >> ~/.zshrc
echo 'autoload -Uz compinit && compinit' >> ~/.zshrc

# Install KUBECTL/KUBECTX
brew install \
	kubectl \
	kubectx \
	derailed/k9s/k9s

# Autosuggestions
brew install zsh-autosuggestions
echo 'source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc

# kubectl completion
echo 'source <(kubectl completion zsh)' >> ~/.zshrc
echo 'KUBE_EDITOR=nvim' >> ~/.zshrc

# Install font
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hermit.zip
unzip Hermit.zip -d ~/Library/Fonts
rm Hermit.zip

