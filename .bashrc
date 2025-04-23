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
    # Check if we're in a Git repo
    git rev-parse --is-inside-work-tree &>/dev/null || return

    FILE="/tmp/promptgit.txt"
    DISP=""

    # Get git status
    git status --porcelain=2 --branch > "$FILE"

    # Extract branch name
    BRANCH=$(grep "^# branch.head" "$FILE" | awk '{print $3}')
    [[ -n "$BRANCH" ]] && DISP=" $BRANCH ["

    # Modified files
    MODIFIED=$(grep ^"1 .M" "$FILE" | wc -l)
    [[ $MODIFIED -gt 0 ]] && DISP="$DISP M"

    # Deleted files 
    DELETED=$(grep ^"1 .D" "$FILE" | wc -l)
    [[ $DELETED -gt 0 ]] && DISP="$DISP D"

    # Untracked files
    UNTRACKED=$(grep ^"? " "$FILE" | wc -l)
    [[ $UNTRACKED -gt 0 ]] && DISP="$DISP U"

    # Staged changes (ready to commit)
    STAGED=$(grep "^1 " "$FILE" | grep -E "^1 [A-Z]" | wc -l)
    [[ $STAGED -gt 0 ]] && DISP="$DISP "

    # something to push
    AHEAD=$(grep "^# branch.ab" "$FILE" | awk '{print $3}' | tr -d '+')
    [[ "$AHEAD" -gt 0 ]] 2>/dev/null && DISP="$DISP "

    DISP="$DISP ]"

    echo "$DISP"
}

# First line: user@host path [git branch]
# Second line: prompt symbol
PS1="${GREEN}\u ${BLUE}\w${YELLOW} \$(parse_git_branch)\n${CYAN}➜ ${RESET}"

# === Exports ===
export PATH="$PATH:/home/aditya/.nvm/versions/node/v22.14.0/bin/"

