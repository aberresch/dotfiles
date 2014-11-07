ZSH=$HOME/.oh-my-zsh

DL_ZSH_RC_LOCAL="$HOME/.zshrc.local"
[ -f "$DL_ZSH_RC_LOCAL" ] && source "$DL_ZSH_RC_LOCAL"

DL_ZSH_ALIASES="$HOME/.aliases"
[ -f "$DL_ZSH_ALIASES" ] && source "$DL_ZSH_ALIASES"

DL_ZSH_ALIASES_LOCAL="$HOME/.aliases.local"
[ -f "$DL_ZSH_ALIASES_LOCAL" ] && source "$DL_ZSH_ALIASES_LOCAL"

ZSH_THEME="daniel_lukas"

plugins=(compleat vi-mode)

source $ZSH/oh-my-zsh.sh

setopt EXTENDED_GLOB

alias ack='ack-grep'
alias pdsh='pdsh -R ssh -w '

function onHosts() {
	local hostGroup="$1"
	shift
	ansible "$hostGroup" -m shell -a "$@"
}

