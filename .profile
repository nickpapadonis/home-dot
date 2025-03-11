#!/bin/sh

# new session do not need to source profile for shell anymore
F=~/.profile-resource
[ -f $F ] && rm $F

# set ~/.profile-resource if you've changed any profile dotfiles
# and each interactive shell will source ~/.profile_ again

# source to top level profile now
F=~/.profile_
[ -f $F ] && source $F
