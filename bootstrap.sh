#!/bin/bash

sudo apt-get install ruby rubygems
sudo gem install rake --no-rdoc --no-ri
sudo ln -sf /var/lib/gems/1.8/bin/rake /usr/bin/rake
