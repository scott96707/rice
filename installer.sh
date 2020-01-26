#!/bin/bash

log() {
	printf '\033[1;33m%s \033[m%s\033[m %s\n' \
		"${3:-->}" "${2:+[1;36m}$1${2:+[m}" "$2"
}

yon() {
	log "$1" "$2" "!>" >&2
	exit 1
}

try() {
	"$@" || yon "Fatal error: $*"
}

trim_string(){
	trim=${1#${1%%[![:space:]]*}}
	trim=${trim%${trim##*[![:space:]]}}
	printf '%s\n' "$trim"
}

# Adding aliases and environment variable to the user's .bashrc
source_variables() {
    # Add for local user
	if grep -lx 'source ~/.config/aliases' $USER_HOME/.bashrc; 
	then
		return 0
	else
		echo "source ~/.config/aliases" >> $USER_HOME/.bashrc
	fi
	if grep -lx 'source ~/.profile' $USER_HOME/.bashrc;
	then
		return 0
	else
		echo "source ~/.profile" >> ~/.bashrc
	fi
    # Add for root user
	if grep -lx "source $USER_HOME/.config/aliases" ~/.bashrc; 
	then
		return 0
	else
		echo "source $USER_HOME/.config/aliases" >> ~/.bashrc
	fi
	if grep -lx 'source $USER_HOME/.profile' ~/.bashrc;
	then
		return 0
	else
		echo "source ~/.profile" >> ~/.bashrc
    fi
}

pre_install() {
    log "Installing RPM Fusion"
    try dnf install -y \
        https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
		https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
		> "$debug"

	log "Enabling Fedora community repos..."     
		try dnf install dnf-plugins-core > "$debug"

    log "Enabling alacritty community repo..."     
	try dnf copr enable -y pschyska/alacritty > "$debug"
	try dnf install alacritty
    log "Adding source variables and aliases" 
    try source_variables
}

install_package() {
	case $2 in
		G)
			log "Installing go package $1..."
			try go get -u "$1" > "$debug"
            ;;
		*)
		    log "Installing $1 - "
		    try dnf install -y "$1" > "$debug"
            ;;
    esac
}

install_packages() {
	[ -f "$pkgfile" ] && (cp "$pkgfile" /tmp/pkgs) || (log "Downloading package list..." && curl -Ls "$pkgfile" > /tmp/pkgs)
	
    packages=$(sed -e '/^$/ d' -e '/^#/ d' -e 's/#.*//' /tmp/pkgs)
    while IFS='	' read -r flag program comment; do
	   program=$(trim_string "$program")
	   install_package $program $flag
   done <<EOF
$packages
EOF
}


install_dots() {
	log "Downloading dot files"
	git clone "$dotrepo" $USER_HOME/.config/rice > "$debug" || log "Dots have already been cloned"
	log "Stowing dot files"
	cd $USER_HOME/.config/rice && stow --target="$HOME" --ignore='gitignore' dots
}

install_vimplug() {
	log "Downloading VimPlug"
	curl -fLo $USER_HOME/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    # On creation, autoload is owned by root:root. This stops VimPlug from working
    chown $SUDO_USER:$SUDO_USER $USER_HOME/.vim/autoload
    # Link vim file with autoload and VimPlug to root user
    ln -s $USER_HOME/.vim ~/
}

cleanup() {
	yon "Aborting rice"
}

main() {
	dotrepo="https://github.com/scott96707/rice.git"
	pkgfile="https://github.com/scott96707/rice/raw/master/packages"
	USER_HOME="/home/$SUDO_USER"

	RICE_DEBUG=1
	if [ "$RICE_DEBUG" == 1 ]; then debug="/dev/stdout"; else debug="/dev/null"; fi

	trap cleanup INT

	pre_install
	install_packages
	install_dots
	install_vimplug
}

main
