# [CONFIG] zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=99999
SAVEHIST=99999

setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
setopt nomatch notify
unsetopt autocd beep extendedglob
bindkey -v

# [CONFIG] compinstall
zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle :compinstall filename '/home/xteven/.zshrc'

autoload -Uz compinit
compinit

# Run zsh-newuser-install again:
# % autoload -Uz zsh-newuser-install
# % zsh-newuser-install -f


# Alias section
alias cp="cp -i"                                                # Confirm before overwriting something
alias mv="mv -i"                                                # Confirm before overwriting something

alias ls='exa --classify --icons'
alias cat='bat --theme=Catppuccin-mocha'
alias neovide='neovide --multigrid'

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

# Environment variables.
export EDITOR='nvim'
export PATH=$PATH:~/.local/bin/

# Basic prompt.
setopt PROMPT_SUBST
PROMPT='%F{blue} ${${(%):-%2~}//\//  }  %f'
RPROMPT='%(?..%F{red}  %?%f)'

# Fix for foot terminfo not installed on most servers
alias ssh="TERM=xterm-256color ssh"
