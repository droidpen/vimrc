#!/bin/bash

sudo apt install vim-gtk3
cd vimrc_linux
cp .vimrc ~/
sudo cp -r .vim/doc/* /usr/share/vim/vim82/doc
sudo cp -r .vim/plugin/* /usr/share/vim/vim82/plugin
cd ..


