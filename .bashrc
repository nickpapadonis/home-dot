[ -f ~/.profile-resource ] && . ~/.profile_

F=/etc/bashrc
[ -f $F ] && . $F

ECHO=${ECHO:="echo"}

shopt -s expand_aliases

# if there are more than 150 possible completions for a word, ask the
# user if he wants to see all of them
# set completion-query-items 150

unset notify

#set bell-style visible
#set keymap emacs-meta

#shopt -s checkwinsize   # Check window after each command.
#shopt -s dotglob        # files beginning with . to show 'echo *'.
#shopt -s histappend     # Append $HISTSIZE lines to $HISTFILE.

# append history vs overwriting it when session is closed
# shopt -s histappend

alias rm='rm -i'

HDIRPRE='bash'
export HISTFILE="${HOME}/.${HDIRPRE}-history"  # Default is ~/.sh_history.
export HISTFILESIZE=${HISTSIZE:-"1000"}               # maximum number of history events to save (in file).

HIST='\!'
EXIT='$?'

F=~/.sh-cmnprompt
[ -f $F ] && . $F

function preexec {
	#	echo "A.sh.value=\"${1}\""
	#	echo "A.sh.command=\"${2}\""
	set -e
	trap '' DEBUG
	if [[ -t 1 ]]; then
		printf "$(settitle_dir ${BASH_COMMAND})" > /dev/tty
	fi
}

cleartitle
setprompt
if [[ -t 1 ]]; then
	trap preexec DEBUG
fi

PROMPT_COMMAND=setprompt
