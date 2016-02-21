EDITOR=vim
DISABLE_AUTO_UPDATE=true
DL_ZSH_GIT_PROMPT=true

HISTSIZE=1000
SAVEHIST=1000

#----

ZSH=$HOME/.oh-my-zsh

DL_ZSH_ALIASES="$HOME/.aliases"
[ -f "$DL_ZSH_ALIASES" ] && source "$DL_ZSH_ALIASES"
DL_ZSH_ALIASES_LOCAL="$HOME/.aliases.local"
[ -f "$DL_ZSH_ALIASES_LOCAL" ] && source "$DL_ZSH_ALIASES_LOCAL"

for f in $HOME/.dl_*.zsh; do
  source $f
done

PROMPT_PREFIX=""
# Check for Environment
ifconfig | grep 10.102 > /dev/null
[[ $? == 0 ]] && DL_ENV="CLUSTER_B"
ifconfig | grep 10.103 > /dev/null
[[ $? == 0 ]] && DL_ENV="CLUSTER_C"
ifconfig | grep 192.168.205 > /dev/null
[[ $? == 0 ]] && DL_ENV="vCD"

case $DL_ENV in
  CLUSTER_B)
    PROMPT_PREFIX="B|"
    DL_ZSH_GIT_PROMPT=false
    ;;
  CLUSTER_C)
    PROMPT_PREFIX="C|"
    DL_ZSH_GIT_PROMPT=false
    ;;
  vCD)
    PROMPT_PREFIX="vCD|"
    DL_ZSH_GIT_PROMPT=false
    ;;
esac

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
	screen -ls | head -n -2 2>/dev/null
fi

DL_ZSH_RC_LOCAL="$HOME/.zshrc.local"
[ -f "$DL_ZSH_RC_LOCAL" ] && source "$DL_ZSH_RC_LOCAL"

DL_ITERM2_INTEGRATION="$HOME/.iterm2_shell_integration.zsh"
[ -f "$DL_ITERM2_INTEGRATION" ] && source "$DL_ITERM2_INTEGRATION"

