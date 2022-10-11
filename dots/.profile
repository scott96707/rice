export VISUAL=vim
export EDITOR=vim
#export PATH=$PATH:$HOME/.local/bin
export MYVIMRC=~/.vimrc
export HISTSIZE=75
export KUBENS="default"
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Rust
#export PATH=$PATH:~/.cargo/bin

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

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

# This handles GPG passphrase entry
export GPG_TTY=$(tty)
[ -f ~/.gnupg/gpg-agent-info ] && source ~/.gnupg/gpg-agent-info
if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
    export GPG_AGENT_INFO
#else
#    eval $( gpg-agent --daemon --options ~/.gnupg/gpg-agent.conf )
fi
