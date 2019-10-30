# $HOME/.kshrc
COLOR_LS=0
SPATHLEN=23

#echo ".kshrc $0"

# code here to sense if called as ENV

#if tty > /dev/null 2>&1 ; then
#    
#fi

if [[ $- = *i* ]]; then
    HAVE_TTY=1
fi

#printf "enabling ksh93 options\n"
unset PROMPT_COMMAND
unset PS1
set -o globstar
export EXTENDED_HISTORY=ON                        # AIX-5.3 ksh datestamp in ksh history.
#export HISTFILE="$HOME/.ksh_history.$$" # Default is ~/.sh_history.
export HISTSIZE=${HISTSIZE:-"2000"}               # Lines of command history logged.
export HISTEDIT=${HISTEDIT:-"$VISUAL"}            # History editor ; replaces obsolete var FCEDIT.
KSH93=1
KSH=1

#set -o vi

## GNU grep, if available, has colorized output.
grep --version 2> /dev/null | grep GNU >/dev/null 2>&1 && alias grep='grep --color=auto'

# When EDITOR == vim ; alias vi to vim
if [[ $EDITOR != "" ]]; then
  [ "`basename $EDITOR`" = "vim" ] && alias vi='vim'
fi

DOT_KSHRC=TRUE

if [ -f ~/.promptrc ]; then
    . ~/.promptrc
fi

export DOT_KSHRC
