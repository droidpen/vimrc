#!/bin/bash

sudo apt install vim-gtk3
cd vimrc_linux
cp .vim ~/
sudo cp .vim/doc/* /usr/share/vim/vim82/doc
sudo cp .vim/plugin/* /usr/share/vim/vim82/plugin
cd ..


