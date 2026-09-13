# Starship (prompt)
eval "$(starship init zsh)"

# Config dir
export XDG_CONFIG_HOME="$HOME/.config"

# PYENV - Now using mise
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - zsh)"
# eval "$(pyenv virtualenv-init -)"
# export PYENV_VIRTUALENV_PROMPT=""

# Created by `pipx` on 2025-02-03 02:10:07
export PATH="$PATH:$HOME/.local/bin"
fpath+=~/.zfunc
autoload -Uz compinit && compinit

# Kubectl / k9s
export KUBE_EDITOR=nvim

# ZSH completions
source <(kubectl completion zsh)
eval "$(git-spice shell completion zsh)"
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
eval "$(curl -fs https://raw.githubusercontent.com/99designs/aws-vault/master/contrib/completions/zsh/aws-vault.zsh)"

# MISE
eval "$($HOME/.local/bin/mise activate zsh)" # added by https://mise.run/zsh

# Aliases
alias rnw='wezterm cli rename-workspace'
alias rnt='wezterm cli set-tab-title'

# Secrets
secrets_file="$XDG_CONFIG_HOME/shell/secrets.env"
if [[ -f "$secrets_file" ]]; then
  set -a
  source "$secrets_file"
  set +a
fi
unset secrets_file
