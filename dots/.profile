export VISUAL=vim
export EDITOR=vim
#export PATH=$PATH:$HOME/.local/bin
export MYVIMRC=~/.vimrc
export HISTSIZE=75
export KUBENS="default"

# Rust
#export PATH=$PATH:~/.cargo/bin

# Go
#export GOPATH=$HOME/go
#export PATH=$PATH:$GOPATH/bin

# TF Creds
source /Users/scottgreen/.tf-creds

# GPG setup
GPG_TTY=$(tty)
export GPG_TTY

# Update PATH for the Google Cloud SDK.
if [ -f '/Users/scottgreen/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/scottgreen/google-cloud-sdk/path.zsh.inc'; fi

# Enable shell command completion for gcloud.
if [ -f '/Users/scottgreen/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/scottgreen/google-cloud-sdk/completion.zsh.inc'; fi
source "$HOME/.cargo/env"
