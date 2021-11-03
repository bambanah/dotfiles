export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.zsh-custom"
ZSH_THEME="robbyrussell"

DISABLE_UPDATE_PROMPT="true"

export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-nvm)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LANG=en_AU.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
  export VISUAL="vim"
else
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

# Aliases
if [ -f $HOME/.aliases ]; then
    source $HOME/.aliases
fi  

# Overwrite builtin cd command with case-insensitive version
cd () {
  builtin cd "$@" 2>/dev/null && return
  emulate -L zsh
  setopt local_options extended_glob
  local matches
  matches=( (#i)${(P)#}(N/) )
  case $#matches in
    0) # There is no match, even case-insensitively. Try cdpath.
      if ((#cdpath)) &&
         [[ ${(P)#} != (|.|..)/* ]] &&
         matches=( $^cdpath/(#i)${(P)#}(N/) ) &&
         ((#matches==1))
      then
        builtin cd $@[1,-2] $matches[1]
        return
      fi
      # Still nothing. Let cd display the error message.
      builtin cd "$@";;
    1)
      builtin cd $@[1,-2] $matches[1];;
    *)
      print -lr -- "Ambiguous case-insensitive directory match:" $matches >&2
      return 3;;
  esac
}

export PATH="$PATH:$HOME/.dotnet/tools/:$HOME/.local/bin"

# SDKman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

eval "$(starship init zsh)"
