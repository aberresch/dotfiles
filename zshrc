EDITOR=vim
DISABLE_AUTO_UPDATE=true
DL_ZSH_GIT_PROMPT=true

HISTSIZE=1000
SAVEHIST=1000

#----

ZSH=$HOME/.oh-my-zsh

ZSH_THEME="daniel_lukas"

for f in $HOME/.dl_*.zsh; do
  source $f
done

plugins=(compleat vi-mode screen)
fpath=(/usr/local/share/zsh-completions $fpath)

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
[[ -f "$DL_ITERM2_INTEGRATION" && $TERM_PROGRAM =~ iTerm ]] && source "$DL_ITERM2_INTEGRATION"


# added by travis gem
[ -f /Users/lukas/.travis/travis.sh ] && source /Users/lukas/.travis/travis.sh
