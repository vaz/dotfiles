#!/bin/bash

clone-or-pull () {
  echo "Updating $1 from $2..."
  [ -d "$1" ] && (cd "$1"; git pull) || git clone "$2" "$1"
}

clone-or-pull "$HOME/.rbenv" 'git://github.com/sstephenson/rbenv.git'
mkdir -p "$HOME/.rbenv/plugins"
clone-or-pull "$HOME/.rbenv/plugins/ruby-build" \
              'git://github.com/sstephenson/ruby-build.git'
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

versionsfile=$(dirname "$0")/ruby-versions
globalversion=$(head -n1 "$versionsfile")

echo
echo "Installing ruby versions from $versionsfile..."

for version in $(cat "$(dirname "$0")/ruby-versions"); do
  echo "Installing ruby-$version..."
  rbenv versions | grep "$version" || rbenv install "$version"
done
rbenv global "$globalversion"
echo "Using ruby-$(rbenv version)."
rbenv rehash

echo
gem install bundler --no-ri --no-rdoc
gem install noexec --no-ri --no-rdoc
rbenv rehash

