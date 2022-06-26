export VISUAL=vim
export EDITOR=vim
#export PATH=$PATH:$HOME/.local/bin
export MYVIMRC=~/.vimrc
export HISTSIZE=10000
export KUBENS="default"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# TF Creds
source ~/.tf-creds

# GPG setup
GPG_TTY=$(tty)
export GPG_TTY

# Update PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi

# Enable shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi
