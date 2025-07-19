# CLI tools & dependencies
sudo dnf install -y neofetch \
	lazygit

# ZSH & Prompt Setup
sudo dnf install zsh
sudo chsh $USER -s $(which zsh)
# Starship setup
curl -sS https://starship.rs/install.sh | sh

# NEOVIM
sudo dnf install -y neovim python3-neovim

# LAZYGIT
echo "  Installing lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm lazygit.tar.gz 
rm lazygit

# Python build deps
sudo dnf install make gcc patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel libuuid-devel gdbm-libs libnsl2

# PYENV
curl https://pyenv.run | bash
# pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

