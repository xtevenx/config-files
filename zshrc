# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=13107
SAVEHIST=13107
setopt nomatch notify
unsetopt autocd beep extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/xteven/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Run zsh-newuser-install again:
# % autoload -Uz zsh-newuser-install
# % zsh-newuser-install -f


# Aliases.
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Environment variables.
export EDITOR='vim'
export PATH=$PATH:/usr/local/texlive/2020/bin/x86_64-linux/
export PATH=$PATH:/home/$USER/.local/bin/

# Basic prompt.
setopt PROMPT_SUBST
PROMPT='%F{blue} ${${(%):-%2~}//\//  }  %f'
RPROMPT='%(?..%F{red}  %?%f)'

# Add the following to /etc/wsl.conf for performance on WSL:
# [interop]
# appendWindowsPath = false
eval $(thefuck --alias)
