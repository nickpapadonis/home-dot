#!/bin/sh

NAME=$(uname)
if [[ $NAME == "Linux" ]]; then
    export IS_LINUX=1
elif [[ $NAME == "SunOS" ]]; then
    export IS_SOE=1
elif [[ $NAME == "Darwin" ]]; then
    export IS_MACOS=1
fi

# source env variables for platform
if [[ -n "$IS_LINUX" ]]; then
    if [ -f ~/.profile_lnx ]; then
	. ~/.profile_lnx
    fi
elif [[ -n "$IS_SOL" ]]; then
    if [ -f ~/.profile_sol ]; then
	. ~/.profile_sol
    fi
elif [[ -n "$IS_MACOS" ]]; then
    if [ -f ~/.profile_macos ]; then
	. ~/.profile_macos
    fi
fi

# source env variables for common
if [[ -f ~/.profile_cmn ]]; then
    . ~/.profile_cmn
fi
