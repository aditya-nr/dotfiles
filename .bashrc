# Skip config for non-interactive shells
case $- in
    *i*) ;; 
    *) return;; 
esac

# History settings
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Auto-resize terminal
shopt -s checkwinsize

# Load user aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# === Prompt ===
# Colors
RESET="\[\e[0m\]"
GREEN="\[\e[32m\]"
BLUE="\[\e[34m\]"
YELLOW="\[\e[33m\]"
CYAN="\[\e[36m\]"
MAGENTA="\[\e[35m\]"
RED="\[\e[31m\]"

# Git branch function
parse_git_branch() {
 git branch 2>/dev/null | grep '*' | sed 's/* //'
}

# First line: user@host path [git branch]
# Second line: prompt symbol
PS1="${GREEN}\u ${BLUE}\w${YELLOW} \$(parse_git_branch)\n${CYAN}➜ ${RESET}"

# === Exports ===
export PATH="$PATH:/home/aditya/.nvm/versions/node/v22.14.0/bin/"

