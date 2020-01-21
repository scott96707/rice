#!/bin/bash

log() {
	printf '\033[1;33m%s \033[m%s\033[m %s\n' \
		"${3:-->}" "${2:+[1;36m}$1${2:+[m}" "$2"
}

yon() {
	log "$1" "$2" "!!" >&2
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

	log "Enabling alacritty community repo..."     
	try dnf copr enable -y pschyska/alacritty > "$debug"
}

install_package() {
	case $2 in
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

install_dot() {
	log "Downloading dot files"
	git clone "$dotrepo" ~/.config/rice > "$debug" || log "Dots have already been cloned"
	(cd ~/.config/rice && stow --target="$HOME" --ignore='gitignore' dots)
}

cleanup() {
	yon "Aborting rice"
}

main() {
	dotrepo=${RICE_REPO:-"https://github.com/scott96707/rice.git"}

	pkgfile=${Rice_PKG:-"https://github.com/scott96707/rice/raw/master/packages"}

	if [ "$RICE_DEBUG" == 1 ]; then debug="/dev/stdout"; else debug="/dev/null"; fi

	trap cleanup INT

	pre_install
	install_packages
	install_dots
}

main
