#!/bin/bash
# This installs all my usually used apps, cli tools and default settings.

clear # Start with a blank terminal.

# Functions to backup if conf file is not symlink and other to use stow dotfiles into the home directory. 
backup_if_not_symlink() {
    local path="$1"
    if [ -e "$path" ] && [ ! -L "$path" ]; then
        mv "$path" "${path}-backup-$(date +%Y-%m-%d-%H%M%S)"
        echo "Backing up $path"
    fi
}

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

ensure_dotfiles_repo() {
    local DIR="$HOME/github/dotfiles-mac"
    local REPO="https://github.com/konsoli/dotfiles-mac.git"

    if [ ! -d "$DIR" ]; then
        echo "$DIR is missing. Cloning dotfiles from $REPO"
        git clone "$REPO" "$DIR"
    else
        echo "Dotfiles repo exists at $DIR"
    fi
}

# Make Homebrew available in this script/session.
if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Checking if homebrew exists. If not, exit with message.
if ! command -v brew >/dev/null 2>&1; then
    echo "homebrew is not installed."
    read -r -p "Press Enter to install homebrew (Ctrl-C to abort)"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "homebrew is now installed."
fi
echo "homebrew exists. let's install apps."

# Install the stuff from Homebrew Brewfile.
brew bundle --file="$HOME/github/dotfiles-mac/Brewfile"

# Checking if stow exists. If not, exit with message.
if ! command -v stow >/dev/null 2>&1; then
    echo "stow is not installed for some reason. try running 'brew install stow' and rerun."
    exit 1
fi
echo "stow exists. let's install dotfiles."

# Let's backup the config files first. Just in case you fuck ship up.
backup_if_not_symlink "$HOME/.vimrc"
backup_if_not_symlink "$HOME/.vim"
backup_if_not_symlink "$HOME/.zshrc"
# backup_if_not_symlink "$HOME/.aerospace.toml" # skipping b/c doesn't exist in system by default.
# backup_if_not_symlink "$HOME/.config/starship.toml" # skipping b/c doesn't exist in system by default.

# Let's stow dotfiles to our home directory.
DOTFILES_DIR="$HOME/github/dotfiles-mac"
stow_package "$DOTFILES_DIR" home

# Let's set a sensible wallpaper.
wallpaper set "$HOME/.walls/wall01.png"

# Let's change some defaults aka settings.
# Great resource: https://macos-defaults.com/dock/tilesize.html
defaults write -g KeyRepeat -int 2 # keys repeat faster
defaults write -g InitialKeyRepeat -int 15 # key repeat starts faster
defaults write -g com.apple.SwiftUI.DisableSolarium -bool YES # removes liquid glass from use - NO to undo.
defaults write com.apple.assistant.support "Assistant Enabled" -bool false # disable ask siri
defaults write com.apple.Siri StatusMenuVisible -bool false # remove siri icon
defaults write com.apple.dock "autohide" -bool "true"  # dock autohide
defaults write com.apple.dock "autohide-delay" -float "0" # dock no autohide delay
defaults write com.apple.dock "tilesize" -int "36" # smaller dock icons
defaults write com.apple.dock "orientation" -string "left" && killall Dock # dock position left
echo "defaults set. this might need a restart."

# End of the script.
echo "That's it. Now, get to work!"
