#!/usr/bin/env ruby

require 'fileutils'

if `which git` and $? != 0
  puts "You probably want to install git."
end

if `which hg` and $? != 0
  puts "You probably want to install hg."
end

if ARGV[0] == '-f'
  puts "Not creating backups!"
  destructive = true
end

HOME = ENV['HOME']
DOTFILES = File.expand_path(File.dirname(__FILE__))

dotfiles = {
  'bash' => {
    "bashrc.#{`uname`.chomp}" => "#{HOME}/.bashrc",
    "bash_aliases"    => "#{HOME}/.bash_aliases",
    "bash_defs"       => "#{HOME}/.bash_defs",
    "profile"         => "#{HOME}/.profile"
  },
  'git'  => {
    "gitconfig"       => "#{HOME}/.gitconfig"
  },
  'hg' => {
    "hgrc"            => "#{HOME}/.hgrc"
  },
  'ruby' => {
    "autotest"        => "#{HOME}/.autotest",
    "irbrc"           => "#{HOME}/.irbrc"
  },
  'vim' => {
    "vimrc"           => "#{HOME}/.vimrc",
    "vimhome"         => "#{HOME}/.vim"
  }
}

dotfiles.each do |dir, files|
  files.each do |src, dst|
    if File.exists? dst or File.symlink? dst
      if destructive or File.symlink? dst
        puts "delete:  #{dst}"
        if File.directory? dst
          FileUtils.rm_rf dst
        else
          File.delete dst
        end
      else
        puts "backup:  #{dst} to #{dst}.bak"
        File.rename(dst, "#{dst}.bak")
      end
    end

    src = "#{DOTFILES}/#{dir}/#{src}"
    File.symlink src, dst
    puts "symlink: #{dst} -> #{src}"
  end
end
