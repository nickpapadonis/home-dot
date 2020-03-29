#!/bin/sh

NAME=`uname`
if [ "$NAME" = "Linux" ]; then
    IS_LINUX=1; export IS_LINUX
elif [ "$NAME" = "SunOS" ]; then
    IS_SOL=1; export IS_SOL
elif [ "$NAME" = "Darwin" ]; then
    IS_MACOS=1; export IS_MACOS
fi

# source env variables for common
if [ -f ~/.profile_cmn ]; then
    . ~/.profile_cmn
fi

# source env variables for platform
if [ -n "$IS_LINUX" ]; then
    if [ -f ~/.profile_lnx ]; then
	. ~/.profile_lnx
    fi
elif [ -n "$IS_SOL" ]; then
    if [ -f ~/.profile_sol ]; then
	. ~/.profile_sol
    fi
elif [ -n "$IS_MACOS" ]; then
    if [ -f ~/.profile_macos ]; then
	. ~/.profile_macos
    fi
fi

