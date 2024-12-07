#!/bin/bash

# System package dependencies
sudo apt-get update
echo "  Installing dependencies..."
sudo apt-get install -y gcc \
	make \
	libevent-dev \
	ncurses-dev \
	build-essential \
	bison \
	pkg-config \
	xclip \
	ripgrep \
	fzf \
	curl \
	zsh \
	stow \
	neofetch

# python build dependencies
sudo apt install -y build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# TMUX
echo "  Installing tmux..."
TMUX_VERSION=$(curl -s "https://api.github.com/repos/tmux/tmux/releases/latest" | jq .tag_name -r)
curl -Lo tmux.tar.gz "https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-{$TMUX_VERSION}.tar.gz"
tar -zxf tmux.tar.gz
cd tmux-${TMUX_VERSION}/
./configure
make && sudo make install
cd ../
rm -rf tmux-${TMUX_VERSION}
rm tmux.tar.gz

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

# PYENV
curl https://pyenv.run | bash
# pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

# NERD FONT
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hermit.zip
unzip Hermit.zip -d ~/.local/share/fonts
rm Hermit.zip
fc-cache -fv

