# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=99999
SAVEHIST=99999
setopt nomatch notify
unsetopt autocd beep extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 1
zstyle :compinstall filename '/home/xteven/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Run zsh-newuser-install again:
# % autoload -Uz zsh-newuser-install
# % zsh-newuser-install -f


# Aliases.
alias d='exa --icons'
alias e='nvim'
alias f='fd'
alias g='rg'
alias v='bat'

# Environment variables.
export EDITOR='nvim'
export PATH=$PATH:~/.local/bin/

# Basic prompt.
setopt PROMPT_SUBST
PROMPT='%F{blue} ${${(%):-%2~}//\//  }  %f'
RPROMPT='%(?..%F{red}  %?%f)'

# Add the following to /etc/wsl.conf for performance on WSL:
# [interop]
# appendWindowsPath = false
eval $(thefuck --alias)
