# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
source ~/aliases
source ~/.profile
export ZSH="/Users/scottgreen/.oh-my-zsh"

plugins=(
	zsh-syntax-highlighting
)

getCtx() {
  grep current-context ~/.kube/config | awk 'NF>1{print $NF}'
}

source $ZSH/oh-my-zsh.sh

# Enable kubectl auto-completion
#[[ /Users/scottgreen/google-cloud-sdk/bin/kubectl ]] && source <(kubectl completion zsh)

# Enable krew plugins
export PATH="${PATH}:${HOME}/.krew/bin"

# setup prompt (borrowed from Mark)
git_prompt() {
    ref=$(git_current_branch)
    [ -z "$ref" ] || echo "%F{11}$ref%f "
}
kube_prompt() {
    ctx=$([ -z "$KUBECTX" ] && "$(echo getCtx)" 2> /dev/null || echo "$KUBECTX" )
    [ -z "$ctx" ] || echo -n "%F{227}$ctx%f:"
    [ -z "$KUBENS" ] || echo -n "%F{46}$KUBENS%f"
}
