# dotfiles-mac
My dotfiles, system settings aka defaults and brew installs.

## to do
* all good rn

## how to use this
simply pull this with ```/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/konsoli/dotfiles-mac/refs/heads/main/install.sh)" ```

also it's possible to do this:
```bash
mkdir ~/github/ && cd ~/github
git clone https://github.com/konsoli/dotfiles-mac
cd dotfiles-mac
./deploy-dotfiles.sh
```

## This is how you commit new changes.
```bash
git add . && git commit -m "comment about changes here" && git push
```
or simply
```bash
dotgit "commit comment"
```

## If git says you shit.
```bash
git pull --rebase
git push
```

## If you don't have git.
```bash
xcode-select --install
```
