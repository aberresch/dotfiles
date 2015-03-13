#!/bin/bash

CWD=$(pwd)

cd ${HOME}
for f in ansible.cfg aliases screenrc zshrc; do
    ln -sf ${CWD}/${f} .${f}
done

git clone https://github.com/lukaspustina/oh-my-zsh.git ${HOME}/.oh-my-zsh
