# oh-my-zsh config
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# --- General config ---
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

source "$HOME/.cargo/env"
source $HOME/.aliases

# --- Tools ---

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

export PATH=$PATH:$HOME/.local/bin

if [ -f '/Users/lachlanunderhill/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/lachlanunderhill/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/lachlanunderhill/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/lachlanunderhill/google-cloud-sdk/completion.zsh.inc'; fi

fpath+=~/.zfunc
autoload -Uz compinit && compinit

eval "$(starship init zsh)"
eval "$(pyenv init -)"
eval "$(zoxide init zsh)"
