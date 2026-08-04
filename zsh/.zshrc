export ZSH="$HOME/.oh-my-zsh"

plugins=(zsh-autosuggestions zsh-syntax-highlighting)

export VISUAL=nvim
export EDITOR="$VISUAL"

source $ZSH/oh-my-zsh.sh

# Aliases
if [ -f $HOME/.aliases ]; then
    source $HOME/.aliases
fi

export PATH="$PATH:$HOME/.local/bin"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
