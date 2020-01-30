sudo -u $SUDO_USER bash -c '\
    cd $HOME/.config/rice \
    stow --target="$HOME/" --ignore="gitignore" dots \
    echo $USER \
    bash
'
