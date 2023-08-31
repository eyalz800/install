#!/bin/bash

set -e

rm -rf nvim-install
rm -rf tmux-conf
rm -rf zsh

git clone https://github.com/eyalz800/nvim-install
git clone https://github.com/eyalz800/tmux-conf
git clone https://github.com/eyalz800/zsh

cd ./nvim-install; ./install.sh; cd ..
cd ./tmux-conf; ./install.sh; cd ..
cd ./zsh; echo 'y\n' | ./install.sh; cd ..

nvim
zsh
