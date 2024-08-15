This repo is very old. The better way of doing things would be to switch to a more declarative OS, like Nix. 
See my [Nix repo](https://github.com/scott96707/nix)

# MacOS setup

Copy the dot files to your ~/ directory.
Import the iTerm2 profile into the app.
Use Bitwarden to retrieve the secret files.

Install [Rectangle](https://rectangleapp.com/) for window management.

Install Homebrew with
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

With Homebrew, install:
```bash
brew install git 
brew install vim 
brew install gpg 
brew install --cask iterm2 
brew install svn 
brew tap homebrew/cask-fonts 
brew install --cask font-source-code-pro
brew install terraform
brew install tree
brew install jq
```
Vim will automagically install the plugins on first run.

Log into Github and create an [SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
Follow Github's instructions to create and add a GPG key for signing commits.
Make sure the GPG agent is running so you don't have to type the GPG passphrase every commit:
- Add "use-agent" to ~/.gnupg/gpg.conf
- `eval $(gpg-agent --daemon --sh)`
- Commit once, type your passphrase. You shouldn't need the phrase for any commits afterward.

Install Electric MDM and then rip its gut out with the script.

Install zsh and then oh-my-zsh with 
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
```

Add in syntax highlighting:
`brew install zsh-syntax-highlighting`
