# dotfiles-mac
My dotfiles, system settings aka defaults and brew installs.

## To do
* fix alias for dotgit so the message comes from the command
* modularize things 
* separate files for functions and actions for the install script
* make the start more robust: 
    * if no xcode then install xcode 
    * if no homebrew, then install homebrew
    * if no stow, then install stow

## This is how you commit shit.
```bash
git add . && git commit -m "comment about changes here" && git push
```

## If git says you shit.
```bash
git pull --rebase
git push
```

## This is how you get this shit.
```bash
mkdir ~/github/ && cd ~/github
git clone https://github.com/konsoli/dotfiles-mac
cd dotfiles-mac
./deploy-dotfiles.sh
```

## If you don't have git.
```bash
xcode-select --install
```
