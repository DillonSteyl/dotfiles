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
	neofetch

# Install TMUX
brew install tmux

# Install LAZYGIT
brew install jesseduffield/lazygit/lazygit

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

# Install font
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hermit.zip
unzip Hermit.zip -d ~/Library/Fonts
rm Hermit.zip

