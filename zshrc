ZSH=$HOME/.oh-my-zsh

HISTSIZE=1000
SAVEHIST=1000

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

# Edit commands in VI via ESC + v
bindkey -M vicmd v edit-command-line

# Enable EMACS key bindings since we use VI mode
bindkey "^R" history-incremental-search-backward
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^D" delete-char-or-list
bindkey "^K" kill-line
bindkey "^H" backward-delete-char

