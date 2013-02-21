#!/bin/bash

VIM_PREFIX=/usr/local

dir="/tmp/dotfiles/vim-$(date| shasum| cut -d' ' -f1)"
mkdir -p $(dirname $dir)

hg clone https://vim.googlecode.com/hg/ "$dir"

cd "$dir/src"
{
  ./configure \
      --prefix="$VIM_PREFIX" \
      --with-features=huge \
      --enable-rubyinterp \
      --enable-pythoninterp \
      --enable-perlinterp \
      --enable-cscope \
      --enable-multibyte
} && make && sudo make install
hash -r

