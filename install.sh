#!/bin/bash

set -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo chattr -i /tmp/sudoers 2>/dev/null || true
    sudo chattr -i /tmp/sudoers_backup 2> /dev/null || true
    sudo cp /etc/sudoers /tmp/sudoers
    sudo cp /etc/sudoers /tmp/sudoers_backup
    sudo chattr -i /tmp/sudoers 2> /dev/null || true
    sudo chmod 777 /tmp/sudoers
    sudo echo $USER 'ALL=(ALL:ALL) NOPASSWD: ALL' >> /tmp/sudoers
    sudo chmod 440 /tmp/sudoers
    sudo chattr +i /tmp/sudoers 2> /dev/null || true
    sudo chattr +i /tmp/sudoers_backup 2>/dev/null || true
    trap 'sudo chattr -i /etc/sudoers 2>/dev/null || true ; \
          sudo chattr -i /tmp/sudoers_backup 2>/dev/null || true ; \
          sudo mv /tmp/sudoers_backup /etc/sudoers ; \
          sudo chattr +i /etc/sudoers 2>/dev/null || true' \
          EXIT
    sudo chattr -i /tmp/sudoers 2> /dev/null || true
    sudo chattr -i /etc/sudoers 2> /dev/null || true
    sudo mv /tmp/sudoers /etc/sudoers
    sudo chattr +i /etc/sudoers 2> /dev/null || true
fi

rm -rf nvim-install
rm -rf tmux-conf
rm -rf zsh

git clone https://github.com/eyalz800/nvim-install
git clone https://github.com/eyalz800/tmux-conf
git clone https://github.com/eyalz800/zsh

cd ./nvim-install; ./install.sh; cd ..
cd ./tmux-conf; ./install.sh; cd ..
cd ./zsh; echo 'y\n' | ./install.sh; cd ..

if [ -z "$NON_INTERACTIVE_INSTALL" ]; then
    nvim
fi

zsh
