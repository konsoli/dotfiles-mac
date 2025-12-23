#!/bin/bash
# This installs all my usually used apps, cli tools and default settings.

# This is a function to backup a file if it's not a symbolic link already.
backup_if_not_symlink() {
    local path="$1"
    if [ -e "$path" ] && [ ! -L "$path" ]; then
        mv "$path" "${path}-backup-$(date +%Y-%m-%d-%H%M%S)"
    fi
}

# This is a function to use stow dotfiles into the home directory.
stow_package() {
    local dotfiles_dir="$1"
    local package="$2"
    local target="${3:-$HOME}"

    if [ -d "$dotfiles_dir/$package" ]; then
        echo "Stowing '$package' from $dotfiles_dir → $target"
        (
            cd "$dotfiles_dir" || return 1
            stow -v --target="$target" "$package"
        )
    else
        echo "Stow package not found: $dotfiles_dir/$package" >&2
        return 1
    fi
}

# Try to make Homebrew immediately available in this script/session. MacOS locations for Homebrew.
if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Checking if homebrew exists. If not, exit with message.
if ! command -v brew >/dev/null 2>&1; then
    echo "homebrew is not installed."
    echo "Install homebrew with the following script:"
    echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    echo "Exiting script."
    exit 1
fi
echo 'homebrew exists. we can install apps.'

# Install the stuff from Homebrew Brewfile.
brew bundle --file="$HOME/github/dotfiles-mac/Brewfile"

# Checking if stow exists. If not, exit with message.
if ! command -v stow >/dev/null 2>&1; then
    echo 'stow is not installed.'
    echo 'Exiting script. If stow was just installed by this script, just rerun this script.'
    exit 1
fi
echo 'stow exists. we can deploy dotfiles.'

# Let's backup the config files first. Just in case you fuck ship up.
backup_if_not_symlink "$HOME/.vimrc"
backup_if_not_symlink "$HOME/.vim"
backup_if_not_symlink "$HOME/.zshrc"
# backup_if_not_symlink "$HOME/.aerospace.toml" # skipping b/c doesn't exist in system by default.
# backup_if_not_symlink "$HOME/.config/starship.toml" # skipping b/c doesn't exist in system by default.

# Let's stow dotfiles to our home directory.
DOTFILES_DIR="$HOME/github/dotfiles-mac"
stow_package "$DOTFILES_DIR" home

# Let's change some defaults aka settings.
defaults write -g KeyRepeat -int 1 # keys repeat faster
defaults write -g InitialKeyRepeat -int 50 # key repeat starts faster
defaults write -g com.apple.SwiftUI.DisableSolarium -bool YES # removes liquid glass from use - NO to undo.
echo "defaults set. this might need a restart."

echo "You're all set. Enjoy. Might need a restart if this was your first run."

echo "These configs were changed:"
ls -lahGp ~/.vim
ls -lahGp ~/.vimrc
ls -lahGp ~/.zshrc
ls -lahGp ~/.aerospace.toml
ls -lahGp ~/.config
ls -lahGp ~/.config/*
echo "That's it. Now, get to work!"
