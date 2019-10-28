#!/bin/bash

test -f ~/.profile && . ~/.profile
test -f ~/.bashrc && . ~/.bashrc

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/np/Downloads/gc/google-cloud-sdk/path.bash.inc ]; then
  source '/Users/np/Downloads/gc/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/np/Downloads/gc/google-cloud-sdk/completion.bash.inc ]; then
  source '/Users/np/Downloads/gc/google-cloud-sdk/completion.bash.inc'
fi
