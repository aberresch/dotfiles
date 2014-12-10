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

function docInfo() {
	[[ -x mongo ]] || return 1;
        local projection="{ _id: 0,
                            filename: 1,
                            mimetype: 1,
                            size: 1,
                            version: 1,
                            version_date: 1,
                            uploader: 1,
                            owner: 1
                          }"
        if [[ "${1}" = "-v" ]]; then
                projection="{}"
                shift;
        fi
        local docId="${1}"
        if [[ -z "$docId" ]]; then
                echo "Usage: docInfo [-v] <documentId>"
                return 1
        fi
        echo "db.metadata.findOne({\"id\":\"$docId\"}, $projection )" | mongo --quiet centerdevice-metadata
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

# Screen Check
if [[ "x${TERM}x" == "xscreenx" ]]; then 
	echo "You're running inside a screen."
else
	screen -ls | head -n -2
fi

