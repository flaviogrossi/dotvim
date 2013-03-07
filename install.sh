#!/bin/sh

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

[ ! -f ~/.vimrc ] && ln -s ~/.vim/vimrc ~/.vimrc
[ ! -f ~/.gvimrc ] && ln -s ~/.vim/gvimrc ~/.gvimrc

vim +BundleInstall! +qa
