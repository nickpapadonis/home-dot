#!/bin/bash
shopt -s expand_aliases

# use a visible bell if one is available
set bell-style visible

# if there are more than 150 possible completions for a word, ask the
# user if he wants to see all of them
set completion-query-items 150

unset notify

set bell-style visible
set keymap emacs-meta

[[ -f /etc/bashrc ]] && . /etc/bashrc
shopt -s checkwinsize   # Check window after each command.
shopt -s dotglob        # files beginning with . to show 'echo *'.
shopt -s histappend     # Append $HISTSIZE lines to $HISTFILE.

export HISTCONTROL=${HISTCONTROL:-"ignoreboth"}       # Ignore repeated cmds, or begin with space.
export HISTIGNORE=${HISTIGNORE:-"ls:ll:la:l.:bg:fg:history"}        # Explicitly ignore file listing.
export HISTTIMEFORMAT=${HISTTIMEFORMAT:-"%F %H:%M  "} # The libc strftime(3) format (man -s3 strftime).
export HISTFILE="$HOME/.hist/history.$$"    # Default is ~/.sh_history.
export HISTFILESIZE=${HISTSIZE:-"2000"}               # maximum number of history events to save (in file).

# append history vs overwriting it when session is closed
shopt -s histappend

if [[ -f ~/.rccmn ]]; then
    . ~/.rccmn
fi

tput setaf 4 2>/dev/null
case $? in
  0) # tput works
     tput sgr0 
     Rc="${BASH:+\\[}${ZSH_VERSION:+%{}`printf \"setaf 1\n\" | \
tput -S`${ZSH_VERSION:+%\}}${BASH:+\\]}"
     Yc="${BASH:+\\[}${ZSH_VERSION:+%{}`printf \"setaf 3\n\" | \
tput -S`${ZSH_VERSION:+%\}}${BASH:+\\]}"
     Bc="${BASH:+\\[}${ZSH_VERSION:+%{}`printf \"setaf 4\n\" | \
tput -S`${ZSH_VERSION:+%\}}${BASH:+\\]}"
     Wc="${BASH:+\\[}${ZSH_VERSION:+%{}`printf \"setaf 7\nbold\n\" | \
tput -S && printf \"setab 0\n\" | tput -S`${ZSH_VERSION:+%\}}${BASH:+\\]}"
     Nc="${BASH:+\\[}${ZSH_VERSION:+%{}`tput sgr0`${ZSH_VERSION:+%\}}${BASH:+\\]}"
  ;;
  *) # setup the ascii methods.
     Rc="${BASH:+\\[}${ZSH_VERSION:+%{}\033[0;31m${ZSH_VERSION:+%\}}${BASH:+\\]}"
     Yc="${BASH:+\\[}${ZSH_VERSION:+%{}\033[0;33m${ZSH_VERSION:+%\}}${BASH:+\\]}"
     Bc="${BASH:+\\[}${ZSH_VERSION:+%{}\033[0;34m${ZSH_VERSION:+%\}}${BASH:+\\]}"
     Wc="${BASH:+\\[}${ZSH_VERSION:+%{}\033[1;37m${ZSH_VERSION:+%\}}${BASH:+\\]}"
     Nc="${BASH:+\\[}${ZSH_VERSION:+%{}\033[0m${ZSH_VERSION:+%\}}${BASH:+\\]}"
  ;;
esac

PROMPT_COMMAND=setprompt
