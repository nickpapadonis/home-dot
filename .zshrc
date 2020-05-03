# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

ECHO=${ECHO:="echo -ne"}

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Override the ZSH prompt
precmd_functions=""

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

function setprompt {
    _PWD=$(echo $PWD| sed "s;$HOME;~;") # strip home directory

    # Read only directories are Red.
    if [[ ! -w "${PWD}" ]] ; then
	CPWD="${Rc}${_PWD}${Nc}"
    else
	CPWD=$_PWD
    fi

    if [[ $TERM == "dumb" ]]; then
        PS1="${HIST}[${SYS}:${CPWD}]$ "
        PS2=">  "
    else
        # ${LOGNAME} for login name
        _PS1="${HIST}${Bc}[${Nc}${SYS}${Bc}:${Nc}${Wc}${CPWD}${Nc}${Bc}]${Nc}${Wc}${Nc}$ ${Nc}"
        _PS2="${Bc}>  ${Nc}"
    fi
    PS1=$(echo -ne $(settitle) >/dev/tty)$(echo -ne ${_PS1})
    PS2=$(echo -ne ${_PS2})
}

precmd() { setprompt }
