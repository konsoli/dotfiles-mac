# dotfiles-mac
My dotfiles, system settings aka defaults and brew installs.

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
