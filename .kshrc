[ -f ~/.profile-resource ] && . ~/.profile_

	case ${.sh.version} in
		*"93u+m/1.1"*)
			KSH_93UM=1
			;;
		"93u")
			KSH_93U=1
			;;
		*)
			KSH_88=1
			;;
	esac

KSH=1

if [[ $- = *i* ]]; then
	HAVE_TTY=1
fi

set -o globstar
set -o emacs

ECHO=${ECHO:="echo"}
#export HISTSIZE=${HISTSIZE:-"2000"}               # Lines of command history logged.
export HISTEDIT=${HISTEDIT:-"$EDITOR"}            # History editor ; replaces obsolete var FCEDIT.
#export HISTIGNORE=${HISTIGNORE:-"ls:ll:la:l.:bg:fg:history"}        # Explicitly ignore file listing.

alias rm='rm -i'

function logout {
	set -e
	trap '' EXIT

	F="~/.logout"
	[ -f $F ] && source $F

	if [ ${SHLVL} -eq 1 ]; then
		case $TERM in
		*xterm*|*rxvt*|dtterm)
			#terminate
			echo "Exit."
			read
			exit
			;;
		*)
			;;
		esac
	fi
}
trap logout EXIT

export HISTFILE="${HOME}/.ksh-history"  # Default is ~/.sh_history.
export HISTFILESIZE=${HISTSIZE:-"1000"}               # maximum number of history events to save (in file).

HIST='\!'
EXIT='$?'

if [ -f ~/.sh-cmnprompt ]; then
	. ~/.sh-cmnprompt
fi

function prompt_cd {
	command 'cd' "$@" && setprompt
}

alias cd="prompt_cd"

setprompt

case $TERM in
	*xterm*|*rxvt*|dtterm)
	if [ -n "$KSH_93UM" ]; then
	    function preexec {
			SC="${.sh.command}"
			trap '' DEBUG
			if [[ -t 1 ]]; then
				if [ "${SC}" = ".sh.value=" ]; then
					_CMD="$(ps -p $$ -o command | tail -n +2)"
					settitle_dir ${_CMD}
				else
					settitle_dir ${SC}
				fi
			fi
	    }
	fi
	;;
    *)
	;;
esac

case $TERM in
	*xterm*|*rxvt*|dtterm)
	if [ -n "$KSH_93UM" ]; then
	    if [[ -t 1 ]]; then
		trap preexec DEBUG
	    fi
	fi
	;;
esac
