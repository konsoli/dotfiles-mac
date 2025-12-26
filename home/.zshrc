export PATH="$PATH:/Users/paul.merisalu/.local/bin"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
#export CLICOLOR=1
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
#PROMPT="%n in %~: " #fallback if no starship

eval "$(/opt/homebrew/bin/brew shellenv)"
source "$HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

dotgit() {
    [ -z "$1" ] && { echo 'Use dotgit "commit msg"' >&2; return 1; }
    local repo="$HOME/github/dotfiles-mac"
    git -C "$repo" add . 
    git -C "$repo" commit -m "$1"
    git -C "$repo" push
}

alias ls='ls -Gp'
alias ph="ssh paulme@192.168.68.250"
alias ha='ssh paulme@192.168.68.241'
alias ll='ls -lh'
alias lla='ls -alh'
alias fastfetch='fastfetch --config examples/13'


if command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi
