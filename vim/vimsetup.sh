#!/bin/sh
curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +"BundleInstall" +"qa"
