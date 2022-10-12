export VISUAL=vim
export EDITOR=vim
#export PATH=$PATH:$HOME/.local/bin
export MYVIMRC=~/.vimrc
export HISTSIZE=75
export KUBENS="default"
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

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
source "$HOME/.cargo/env"
