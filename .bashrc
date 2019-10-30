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

[ -f /etc/bashrc ] && . /etc/bashrc
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

if [ -f ~/.promptrc ]; then
    . ~/.promptrc
fi
