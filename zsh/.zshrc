# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
#(cat ~/.cache/wal/sequences &)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/lachie/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Aliases
alias p="sudo pacman"
alias screenshot="scrot ~/Pictures/screenshots/%Y-%M-%d-%H%M%S_scrot.png"
alias np="nvim ~/.config/polybar"
alias nb="nvim ~/.config/bspwm/bspwmrc"
alias ns="nvim ~/.config/sxhkd/sxhkdrc"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# TODO: Implement theme switch
# wal-update() {
#   wal -n -i "$@"
#   spicetify update
#   pywal-discord -p ~/install/LinuxED/EnhancedDiscord/styles
# }

export PATH=$PATH:/home/lachie/.yarn/bin
