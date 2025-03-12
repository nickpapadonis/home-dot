#!/bin/ksh

fl=".Xresources
.bash_logout
.bash_profile
.bashrc
.editrc
.edwin
.edwin-x
.emacs
.fonts.conf
.gitconfig
.gitignore
.hushlogin
.inputrc
.kshrc
.logout
.profile
.profile_
.profile_cmn
.profile_lnx
.profile_macos
.profile_sol
.scheme.init
.sh-cmnprompt
.sh-rccmn
.vimrc
.xmodmap
.zprofile
.zshrc"

while IF= read -r f; do
	cp ~/$f .
done <<< "$fl"
