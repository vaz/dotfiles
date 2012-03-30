#!/bin/bash

cd /tmp
hg clone https://vim.googlecode.com/hg/ vim
cd vim/src
./configure --prefix=/usr/local --with-features=huge --enable-rubyinterp --enable-pythoninterp --enable-perlinterp --enable-cscope --enable-multibyte
make
sudo make install
hash -r

