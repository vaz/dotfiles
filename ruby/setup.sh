#!/bin/bash

git clone git://github.com/sstephenson/rbenv.git $HOME/.rbenv
mkdir -p $HOME/.rbenv/plugins
git clone git://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
rbenv install 1.9.3-p125
rbenv global 1.9.3-p125
rbenv rehash
gem install bundler
gem install noexec
rbenv rehash

