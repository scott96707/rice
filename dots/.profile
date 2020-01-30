export TERMINAL=alacritty
export VISUAL=vim
export EDITOR=vim
export PATH=$PATH:$HOME/.local/bin
export MYVIMRC=~/.config/.vimrc

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 5)\]\\$ \[$(tput sgr0)\]"
if [ -f ~/Pictures/Wallpapers/* ] 
then
    feh --randomize --bg-fill ~/Pictures/Wallpapers/*
fi
