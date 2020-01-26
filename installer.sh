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

pre_install() {
	log "Installing RPM Fusion"
	try dnf install -y \
		https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
		https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
		> "$debug"

	log "Enabling Fedora community repos..."     
		try dnf install dnf-plugins-core > "$debug"

	# log "Enabling alacritty community repo..."     
	# try dnf copr enable -y pschyska/alacritty > "$debug"
	# try dng install alacritty
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
	
    packages=$(sed '/^$/d' /tmp/pkgs | sed '/^#/d')
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
	(cd $USER_HOME/.config/rice && stow -R --target="$HOME" --ignore='gitignore' dots)
}

install_vimplug() {
	log "Downloading VimPlug"
	curl -fLo $USER_HOME/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

# Adding aliases to the user's .bashrc
source_aliases() {
	if [ grep -Fxq "source ~/.config/aliases" $USER_HOME/.bashrc ];
	then
		return 1
	else
		echo "source ~/.config/aliases" >> $USER_HOME/.bashrc
	fi
}

cleanup() {
	yon "Aborting rice"
}

main() {
	dotrepo="https://github.com/scott96707/rice.git"
	pkgfile="https://github.com/scott96707/rice/raw/master/packages"
	USER_HOME="/home/$SUDO_USER"

	if [ "$RICE_DEBUG" == 1 ]; then debug="/dev/stdout"; else debug="/dev/null"; fi

	trap cleanup INT

	pre_install
	install_packages
	install_dots
	install_vimplug
}

main
