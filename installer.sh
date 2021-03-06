#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # ...
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX

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

    log "Enabling alacritty community repo..."     
	try dnf copr enable -y pschyska/alacritty
	try dnf install -y alacritty

    log "Adding yum/dnf with GCloud SDK repo"
    sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
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

install_dots() {
	log "Downloading dot files"
	sudo -u $SUDO_USER git clone "$dotrepo" $USER_HOME/.config/rice > "$debug" || log "Dots have already been cloned"
	log "Stowing dot files"
	sudo -u $SUDO_USER bash -c 'cd $HOME/.config/rice; 
        stow --target="$HOME/" --ignore="gitignore" dots;' > "$debug" || log "Dots failed to stow"
}
source_variables() {
    log "Adding source variables and aliases" 
	if grep -lx "source ~/.config/aliases" $USER_HOME/.bashrc; then return 0;
    else echo "source ~/.config/aliases" >> $USER_HOME/.bashrc;	fi
	if grep -lx "source ~/.profile" $USER_HOME/.bashrc;	then return 0;
	else echo "source ~/.profile" >> $USER_HOME/.bashrc; fi
}

source_root () {
    log "Adding root user links and settings"
    cd $HOME && ln -s $USER_HOME/.vimrc && ln -s $USER_HOME/bin/
	if grep -lx "source $USER_HOME/.config/aliases" $HOME/.bashrc; then return 0;
	else echo "source $USER_HOME/.config/aliases" >> $HOME/.bashrc;	fi
	if grep -lx "source $USER_HOME/.profile" $HOME/.bashrc; then return 0; 
    else echo "source $USER_HOME/.profile" >> $HOME/.bashrc; fi
}

install_vimplug() {
	log "Downloading VimPlug"
	sudo -u $SUDO_USER curl -fLo $USER_HOME/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ln -s $USER_HOME/.vim ~/
	vim +'PlugInstall --sync' +qa
}

install_fonts() {
	mkdir ~/.local/share/fonts
	cp ~/.config/rice/dots/.fonts/*
	fc-cache -v
}

move_alacritty() {
	mkdir ~/.alacritty/
	cp ~/.config/rice/alacritty/alacritty.yml ~/.alacritty/ 
}

setup_vscode() {
    log "VSCode - Adding Microsoft Repo"
    VS_CODE_REPO='[vscode]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc'
	if [ -f /etc/yum.repos.d/vscode.repo ];	then return 0;
	else echo "$VS_CODE_REPO" > /etc/yum.repos.d/vscode.repo; fi
    
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    try code --install-extension Shan.code-settings-sync
    dnf check-update
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
    source_variables
    source_root 
    install_vimplug
	install_fonts
	move_alacritty
}
main
