export VISUAL=vim
export EDITOR=vim
export MYVIMRC=~/.vimrc
export HISTSIZE=75
export KUBENS="default"
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# These fix issues with CF warp and npm/cypress. Download the cf .pem cert to
# that directory first
export npm_config_cafile="~/cloudflare/Cloudflare_CA.pem"
export CYPRESS_DOWNLOAD_USE_CA=1

# Brew setup for NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || \
  printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# TF Creds
source ~/.tf-creds

# GPG setup
GPG_TTY=$(tty)
export GPG_TTY
