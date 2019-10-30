#
# Simple profile places /usr/bin at front, followed by /usr/sbin.
#
# Use less(1) or more(1) as the default pager for the man(1) command.
#


if [ -f /usr/bin/less ]; then
    export PAGER="/usr/bin/less -ins"
elif [ -f /usr/bin/more ]; then
    export PAGER="/usr/bin/more -s"
fi

export EDITOR="emacs"

# Enable color lS
COLOR_LS=0
#
# Define default prompt to <username>@<hostname>:<path><"($|#) ">
# and print '#' for user "root" and '$' for normal users.
#
# Currently this is only done for bash/pfbash(1).
#

if [[ `uname` == "Linux" ]]; then
    export IS_LINUX=1
elif [[ `uname` == "SunOS" ]]; then
    export IS_SOE=1
elif [[ `uname` == "Darwin" ]]; then
    export IS_MACOS=1
fi

# source env variables for platform
if [[ "$IS_LINUX" == "1" ]]; then
    if [ -f ~/.profile_lnx ]; then
	. ~/.profile_lnx
    fi
elif [[ "$IS_SOL" == "1" ]]; then
    if [ -f ~/.profile_sol ]; then
	. ~/.profile_sol
    fi
elif [[ "$IS_MACOS" == "1" ]]; then
    if [ -f ~/.profile_macos ]; then
	. ~/.profile_macos
    fi
fi

# source env variables for common
if [ -f ~/.profile_cmn ]; then
    . ~/.profile_cmn
fi
