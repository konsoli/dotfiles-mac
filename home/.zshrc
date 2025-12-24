export PATH="$PATH:/Users/paul.merisalu/.local/bin"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

alias ls='ls -Gp'
alias pihole="ssh paulme@192.168.68.250"
alias home="ssh paulme@192.168.68.241"
alias ll='ls -lh'
alias lla='ls -alh'
alias fastfetch='fastfetch --config examples/13'

eval "$(starship init zsh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

if command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi
# Letters indicate the colour:
#a = black
#b = red
#c = green
#d = brown
#e = blue
#f = magenta
#g = cyan
#h = light gray
#x = default
#The position in the sequence indicate what we’re trying to colour. This is the sequence:
#DIR
#SYM_LINK
#SOCKET
#PIPE
#EXE
#BLOCK_SP
#CHAR_SP
#EXE_SUID
#EXE_GUID
#DIR_STICKY
#DIR_WO_STICKY
