#!/bin/bash
FILES="aliases ansible.cfg screenrc vimrc.before vimrc.after zshrc"
DL_FILES="$(ls -1 dl_*.zsh)"
MKDIRS="${HOME}/.janus"
DIRS="janus/ftdetect janus/lukas janus/daniel"
GITREPOS="\
  https://github.com/lukaspustina/oh-my-zsh.git,${HOME}/.oh-my-zsh \
  https://github.com/carlhuda/janus.git,${HOME}/.vim,rake \
  https://github.com/gavinbeatty/dragvisuals.vim.git,${HOME}/.janus/dragvisuals.vim.git \
  https://github.com/chase/vim-ansible-yaml.git,${HOME}/.janus/vim-ansible-yaml.git \
  https://github.com/altercation/vim-colors-solarized.git,${HOME}/.janus/vim-colors-solarized.git \
  https://github.com/atweiden/vim-vmath.git,${HOME}/.janus/vim-vmath.git \
  https://github.com/tpope/vim-surround.git,${HOME}/.janus/vim-surround.git \
  https://github.com/tpope/vim-repeat.git,${HOME}/.janus/vim-repeat.git \
  https://github.com/sjl/gundo.vim.git,${HOME}/.janus/gundo \
  https://github.com/editorconfig/editorconfig-vim.git,${HOME}/.janus/editorconfig-vim \
  https://github.com/Chiel92/vim-autoformat.git,${HOME}/.janus/vim-autoformat \
"

CWD=$(pwd)
uname | grep Darwin &> /dev/null && isDarwin=true

cd ${HOME}

# remove old link to renamed file to prevent duplicate
rm -f .dl_centerdevice.zsh

for f in $FILES $DL_FILES; do
    ln -v -sf ${CWD}/${f} .${f}
done

for d in $MKDIRS; do
  mkdir -p $d
done

for d in $DIRS; do
  if [ -z $isDarwin ]; then
    ln -v -sfn ${CWD}/${d} .${d}
  else
    ln -v -sfh ${CWD}/${d} .${d}
  fi
done

for i in $GITREPOS; do IFS=","; set $i
  if [ -d $2 ]; then
    (cd $2; git pull --rebase)
  else
    git clone $1 $2
  fi
  if [ -n $3 ]; then
    (cd $2; $3)
  fi
done

# Get iTerm2 shell integration
curl -L https://iterm2.com/misc/zsh_startup.in >> ~/.iterm2_shell_integration.zsh

