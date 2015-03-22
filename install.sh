#!/bin/bash
FILES="aliases ansible.cfg dl_centerdevice.zsh screenrc vimrc.before vimrc.after zshrc"
MKDIRS="${HOME}/.janus"
DIRS="janus/ftdetect janus/lukas"
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
"

CWD=$(pwd)

cd ${HOME}
for f in $FILES; do
    ln -v -sf ${CWD}/${f} .${f}
done

for d in $MKDIRS; do
  mkdir -p $d
done

for d in $DIRS; do
  ln -v -sf ${CWD}/${d} .${d}
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

