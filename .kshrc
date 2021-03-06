if [[ $- = *i* ]]; then
    HAVE_TTY=1
fi

if [ -z $KSH_VERSION ]; then
    KSH_88=1
fi

if [ -z $KSH_88 ]; then
    set -o globstar
fi

ECHO=${ECHO:="echo -ne"}
export EXTENDED_HISTORY=ON                        # AIX-5.3 ksh datestamp in ksh history.
export HISTFILE="$HOME/.ksh_history" # Default is ~/.sh_history.
export HISTSIZE=${HISTSIZE:-"2000"}               # Lines of command history logged.
export HISTEDIT=${HISTEDIT:-"$EDITOR"}            # History editor ; replaces obsolete var FCEDIT.
export HISTIGNORE=${HISTIGNORE:-"ls:ll:la:l.:bg:fg:history"}        # Explicitly ignore file listing.

# run logout script on logout
if [ -z $KSH_88 ]; then
   trap '. $HOME/.logout; exit' 0
fi

HIST="\! "
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
     # ksh has problems with bold, so no bold
     Wc="${BASH:+\\[}${ZSH_VERSION:+%{}\033[1;37m${ZSH_VERSION:+%\}}${BASH:+\\]}"
     Nc="${BASH:+\\[}${ZSH_VERSION:+%{}\033[0m${ZSH_VERSION:+%\}}${BASH:+\\]}"
  ;;
  *) # setup the ascii methods.
     if [[ $TERM != "dumb" ]]; then
	 Rc="${BASH:+\\[}${ZSH_VERSION:+%{}\033[0;31m${ZSH_VERSION:+%\}}${BASH:+\\]}"
	 Yc="${BASH:+\\[}${ZSH_VERSION:+%{}\033[0;33m${ZSH_VERSION:+%\}}${BASH:+\\]}"
	 Bc="${BASH:+\\[}${ZSH_VERSION:+%{}\033[0;34m${ZSH_VERSION:+%\}}${BASH:+\\]}"
	 Wc="${BASH:+\\[}${ZSH_VERSION:+%{}\033[1;37m${ZSH_VERSION:+%\}}${BASH:+\\]}"
	 Nc="${BASH:+\\[}${ZSH_VERSION:+%{}\033[0m${ZSH_VERSION:+%\}}${BASH:+\\]}"
     fi
   ;;
esac

function prompt_cd {
    ## The command builtin does not exist in some ksh88, notable hp-ux 11i, but does in Solaris 10.
    command 'cd' "$@" && setprompt && settitle
}

alias cd="prompt_cd"

setprompt && settitle
