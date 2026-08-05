# oh-my-zsh config
export ZSH="$HOME/.oh-my-zsh"

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

export PATH=$PATH:$HOME/.local/bin

if [ -f '/Users/lachlanunderhill/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/lachlanunderhill/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/lachlanunderhill/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/lachlanunderhill/google-cloud-sdk/completion.zsh.inc'; fi

fpath+=~/.zfunc
autoload -Uz compinit && compinit

eval "$(starship init zsh)"
if [ -z "$DISABLE_ZOXIDE" ]; then
    eval "$(zoxide init zsh)"
fi
eval "$(fnm env --use-on-cd --shell zsh)"

# pnpm
export PNPM_HOME="/Users/lachlanunderhill/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
