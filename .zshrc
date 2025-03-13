# Set up the prompt
[ -f ~/.profile-resource ] && . ~/.profile_

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000

# Override the ZSH prompt
precmd_functions=""
ECHO=${ECHO:="echo"}
HIST='%!'
EXIT='%?'

alias rm='rm -i'

export HISTFILE="${HOME}/.zsh-history"  # Default is ~/.sh_history.
export HISTFILESIZE=${HISTSIZE:-"1000"}               # maximum number of history events to save (in file).

[ -f ~/.sh-cmnprompt ] && . ~/.sh-cmnprompt

function logout {
	set -e
	trap '' EXIT
	F="~/.logout"
	[ -f $F ] && source $F
	if [[ "$TERM_PROGRAM" != "Apple_Terminal" ]]; then
		if [ ${SHLVL} -eq 1 ]; then
			case $TERM in
			*xterm*|*rxvt*|dtterm)
				terminate
				echo "Exit."
				read
				exit
				;;
			*)
				;;
			esac
		fi
	fi
}
trap logout EXIT

function precmd_title {
	print -n $(settitle_dir "${1}")
}

case $TERM in
	*xterm*|*rxvt*|dtterm)
		cleartitle
		preexec() { precmd_title $1 }
		;;
esac

precmd() { setprompt }
