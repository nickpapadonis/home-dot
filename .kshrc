[ -f ~/.profile-resource ] && . ~/.profile_

case ${.sh.version} in
	*"93u+m/1"*)
		KSH_93UM=1
		KSH=1
		;;
	"93u")
		KSH_93U=1
		KSH=1
		;;
	*)
		KSH_88=1
		KSH=1
		;;
esac

if [[ $- = *i* ]]; then
	HAVE_TTY=1
fi

set -o globstar
set -o emacs

ECHO=${ECHO:="echo"}
#export EXTENDED_HISTORY=ON                        # AIX-5.3 ksh datestamp in ksh history.
#export HISTFILE="$HOME/.ksh_history" # Default is ~/.sh_history.
#export HISTSIZE=${HISTSIZE:-"2000"}               # Lines of command history logged.
export HISTEDIT=${HISTEDIT:-"$EDITOR"}            # History editor ; replaces obsolete var FCEDIT.
#export HISTIGNORE=${HISTIGNORE:-"ls:ll:la:l.:bg:fg:history"}        # Explicitly ignore file listing.

alias rm='rm -i'

# run logout script on logout

function logout {
	set -e
	trap '' EXIT
	if [ -f $F ]; then
		. ~/.logout
	fi
	terminate
}
trap logout EXIT

HDIRPRE='ksh'
export HISTFILE="${HOME}/.${HDIRPRE}-history"  # Default is ~/.sh_history.
export HISTFILESIZE=${HISTSIZE:-"1000"}               # maximum number of history events to save (in file).

HIST='\!'
EXIT='$?'

if [ -f ~/.sh-cmnprompt ]; then
	. ~/.sh-cmnprompt
fi

function prompt_cd {
	## The command builtin does not exist in some ksh88, notable hp-ux 11i, but does in Solaris 10.
	command 'cd' $@ && setprompt
}

alias cd="prompt_cd"

if [ -n "$KSH_93UM" ]; then
	function preexec {
		#		echo "A.sh.value=\"${SV}\""
		#		echo "A.sh.command=\"${SC}\"" 
		SC="${.sh.command}"
		set -e
		trap '' DEBUG
		if [[ -t 1 ]]; then
			#echo "A.sh.level=${.sh.level}"
			if [ "${SC}" != ".sh.value=" ]; then
				print -n "$(settitle_dir ${SC})"
			fi
		fi
	}
fi

cleartitle
prompt_cd

if [ -n "$KSH_93UM" ]; then
	if [[ -t 1 ]]; then
		trap preexec DEBUG
	fi
fi
