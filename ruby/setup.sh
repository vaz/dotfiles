#!/bin/bash

git clone git://github.com/sstephenson/rbenv.git $HOME/.rbenv
mkdir -p $HOME/.rbenv/plugins
git clone git://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rbenv versions | grep '1.9.3-p194' || rbenv install 1.9.3-p194
rbenv global 1.9.3-p125
rbenv rehash
gem install bundler --no-ri --no-rdoc
gem install noexec --no-ri --no-rdoc
rbenv rehash

