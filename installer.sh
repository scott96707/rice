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
    ( "$@" || yon "Fatal error: $*" )
}

trim_string(){
	trim=${1#${1%%[![:space:]]*}}
	trim=${trim%${trim##*[![:space:]]}}
	printf '%s\n' "$trim"
}

pre_install() {
    log "Installing RPM Fusion"
    try dnf install -y \
        https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
		https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

	log "Enabling Fedora community repos..."     
		try dnf install dnf-plugins-core

    log "Adding yum/dnf with GCloud SDK repo"
    sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM

}

install_package() {
	case $2 in
		G)
			log "Installing go package $1..."
			try go get -u "$1"
            ;;
        X)
            log "Skipping installation of $1"
            ;;
		*)
		    log "Installing $1... "
		    try dnf install -y "$1"
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

source_variables() {
    log "Adding source variables and aliases" 
    cp ./aliases ~/aliases
    cp ./dots/.profile ~/.profile
    cp ./dots/.vimrc ~/.vimrc
}

install_vimplug() {
	log "Downloading VimPlug"
    cd ~/
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +'PlugInstall --sync' +qa
}

install_fonts() {
	mkdir ~/.local/share/fonts
	cp ~/.config/rice/dots/.fonts/* ~/.local/share/fonts
	fc-cache -v
}

move_alacritty() {
	mkdir ~/.alacritty/
}

cleanup() {
	yon "Aborting rice"
}

main() {
	dotrepo="https://github.com/scott96707/rice.git"
	pkgfile="https://github.com/scott96707/rice/raw/master/packages"
	if [ "$RICE_DEBUG" == 1 ]; then debug="/dev/stdout"; else debug="/dev/null"; fi
	trap cleanup INT

    pre_install
    install_packages
    source_variables
    source_root 
    install_vimplug
	install_fonts
}
main
