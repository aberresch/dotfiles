ZSH=$HOME/.oh-my-zsh

HISTSIZE=1000
SAVEHIST=1000

DL_ZSH_RC_LOCAL="$HOME/.zshrc.local"
[ -f "$DL_ZSH_RC_LOCAL" ] && source "$DL_ZSH_RC_LOCAL"

DL_ZSH_ALIASES="$HOME/.aliases"
[ -f "$DL_ZSH_ALIASES" ] && source "$DL_ZSH_ALIASES"

DL_ZSH_ALIASES_LOCAL="$HOME/.aliases.local"
[ -f "$DL_ZSH_ALIASES_LOCAL" ] && source "$DL_ZSH_ALIASES_LOCAL"

PROMPT_PREFIX=""
# Check for Environment
ifconfig | grep 10.102 > /dev/null
[[ $? == 0 ]] && PROMPT_PREFIX="B|"
ifconfig | grep 10.103 > /dev/null
[[ $? == 0 ]] && PROMPT_PREFIX="C|"
ifconfig | grep 192.168.205 > /dev/null
[[ $? == 0 ]] && PROMPT_PREFIX="vCD|"


ZSH_THEME="daniel_lukas"

plugins=(compleat vi-mode screen)

source $ZSH/oh-my-zsh.sh

setopt EXTENDED_GLOB

alias ack='ack-grep'
alias pdsh='pdsh -R ssh -w '

function onHosts() {
	local hostGroup="$1"
	shift
	ansible "$hostGroup" -m shell -a "$@"
}

function cd_userInfo() {
        [[ -x /usr/bin/mongo ]] || return 2;
        local projection="{ _id: 0,
                            id: 1,
                            email: 1,
                            first_name: 1,
                            last_name: 1,
                            distributor: 1,
                            role: 1,
                            status: 1,
                            tenant: 1,
                            last_login: 1,
                            'upload_settings.email_upload_alias': 1
                          }"
        if [[ "${1}" = "-v" ]]; then
                projection="{}"
                shift;
        fi
        local userId="${1}"
        if [[ -z "$userId" ]]; then
                echo "Usage: userInfo [-v] <userId|uploadId>"
                return 1
        fi
        echo "db.user.findOne({ \$or:[ {\"id\":\"$userId\"}, {\"upload_settings.email_upload_alias\":\"$userId\"}]}, $projection )" | mongo --quiet centerdevice-security

}

function cd_docInfo() {
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

