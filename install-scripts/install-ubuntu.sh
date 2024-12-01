#!/bin/bash

# System package dependencies
sudo apt-get update
echo "  Installing dependencies..."
sudo apt-get install -y gcc \
	xclip \
	make \
	ripgrep \
	fzf \
	curl \
	zsh \
	stow \
	neofetch

# TMUX
echo "  Installing tmux..."
sudo apt-get install -y tmux

# LAZYGIT
echo "  Installing lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm lazygit.tar.gz 
rm lazygit

# STARSHIP PROMPT
curl -sS https://starship.rs/install.sh | sh
# set zsh as default shell
echo "  Changing default shell to zsh..."
chsh -s $(which zsh)

# NVIM
echo "  Installing NVIM..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo rm nvim-linux64.tar.gz

# NERD FONT
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hermit.zip
unzip Hermit.zip -d ~/.local/share/fonts
rm Hermit.zip
fc-cache -fv

