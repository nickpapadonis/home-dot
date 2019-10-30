if [[ $- = *i* ]]; then
    HAVE_TTY=1
fi

unset PROMPT_COMMAND
unset PS1
set -o globstar
export EXTENDED_HISTORY=ON                        # AIX-5.3 ksh datestamp in ksh history.
export HISTFILE="$HOME/.hist/history.$$" # Default is ~/.sh_history.
export HISTSIZE=${HISTSIZE:-"2000"}               # Lines of command history logged.
export HISTEDIT=${HISTEDIT:-"$VISUAL"}            # History editor ; replaces obsolete var FCEDIT.
export HISTIGNORE=${HISTIGNORE:-"ls:ll:la:l.:bg:fg:history"}        # Explicitly ignore file listing.

# run logout script on logout
trap '. $HOME/.logout; exit' 0

if [ -f ~/.promptrc ]; then
    . ~/.promptrc
fi
