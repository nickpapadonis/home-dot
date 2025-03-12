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
HDIRPRE="zsh"

alias rm='rm -i'

export HISTFILE="${HOME}/.${HDIRPRE}-history"  # Default is ~/.sh_history.
export HISTFILESIZE=${HISTSIZE:-"1000"}               # maximum number of history events to save (in file).

[ -f ~/.sh-cmnprompt ] && . ~/.sh-cmnprompt

function logout {
	set -e
	trap '' EXIT
	if [ -f $F ]; then
		. ~/.logout
	fi
	case $TERM in
    *xterm*|*rxvt*|dtterm)
		terminate
		read
		exit
		;;
	*)
		;;
	esac
}
trap logout EXIT

function precmd_title {
	print -n $(settitle_dir "${2}")
}

case $TERM in
	*xterm*|*rxvt*|dtterm)
		cleartitle
		preexec() { precmd_title $@ }
		;;
esac

precmd() { setprompt }
