#!/bin/bash

clone-or-pull () {
  echo "Updating $1 from $2..."
  [ -d "$1" ] && (cd "$1"; git pull) || git clone "$2" "$1"
}

clone-or-pull "$HOME/.rbenv" 'git://github.com/sstephenson/rbenv.git'
mkdir -p "$HOME/.rbenv/plugins"
clone-or-pull "$HOME/.rbenv/plugins/ruby-build" \
              'git://github.com/sstephenson/ruby-build.git'
clone-or-pull "$HOME/.rbenv/plugins/rbenv-gem-rehash" \
              'git://github.com/sstephenson/rbenv-gem-rehash.git'
clone-or-pull "$HOME/.rbenv/plugins/rbenv-binstubs" \
              'git://github.com/ianheggie/rbenv-binstubs'
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

versionsfile=$(dirname "$0")/ruby-versions
globalversion=$(head -n1 "$versionsfile")

echo
echo "Installing ruby versions from $versionsfile..."

for version in $(cat "$(dirname "$0")/ruby-versions"); do
  echo "Installing ruby-$version..."
  rbenv versions | grep "$version" || {
    rbenv install "$version"
    export RBENV_VERSION="$version"
    rbenv version
    rbenv rehash
    gem install bundler --no-ri --no-rdoc
    gem install noexec --no-ri --no-rdoc
    rbenv rehash
  }
done

echo "$globalversion" > "$HOME/.rbenv/version"
echo
echo "global ruby: $globalversion"


