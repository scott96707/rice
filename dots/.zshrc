# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
source ~/aliases
source ~/.profile
export ZSH="~/.oh-my-zsh"

getCtx() {
  grep current-context ~/.kube/config | awk 'NF>1{print $NF}'
}

source "${ZSH}"/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable kubectl auto-completion
#[[ ~/google-cloud-sdk/bin/kubectl ]] && source <(kubectl completion zsh)

git_prompt() {
    ref=$(git_current_branch)
    [ -z "$ref" ] || echo "%F{11}$ref%f "
}
kube_prompt() {
    ctx=$([ -z "$KUBECTX" ] && "$(echo getCtx)" 2> /dev/null || echo "$KUBECTX" )
    [ -z "$ctx" ] || echo -n "%F{227}$ctx%f:"
    [ -z "$KUBENS" ] || echo -n "%F{46}$KUBENS%f"
}
PROMPT='($(kube_prompt)) %F{9}%2~%f $(git_prompt)%B%F{166}ʡ%b%f '

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sgreen/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sgreen/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sgreen/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sgreen/google-cloud-sdk/completion.zsh.inc'; fi
