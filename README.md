# MacOS setup

Copy the dot files to your ~/ directory.
Import the iTerm2 profile into the app.
Use Bitwarden to retrieve the secret files.

Install Homebrew with
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install VimPlug with
```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Inside the .vimrc, run :PlugInstall

Install Electric MDM and then rip its gut out with the script.

Install zsh and then oh-my-zsh with 
```bash
brew install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
```

Install iTerm2 with
``` bash
brew install --cask iterm2
brew tap homebrew/cask-fonts && brew install --cask font-source-code-pro
```

Setup a new Github SSH key.
