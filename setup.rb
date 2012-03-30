#!/usr/bin/env ruby

require 'fileutils'

puts "You probably want to install git." if `which git` and $? != 0
puts "You probably want to install hg." if `which hg` and $? != 0
puts "You probably want to install bash-completion" if `which __git_ps1` and $? != 0

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
  'bin' => {
    "ack"             => "#{HOME}/bin/ack"
  },
  'git'  => {
    "gitconfig"       => "#{HOME}/.gitconfig"
  },
  'hg' => {
    "hgrc"            => "#{HOME}/.hgrc"
  },
  'ruby' => {
    "autotest"        => "#{HOME}/.autotest",
    "irbrc"           => "#{HOME}/.irbrc",
    "pryrc"           => "#{HOME}/.pryrc"
  },
  'screen' => {
    "screenrc"        => "#{HOME}/.screenrc"
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

    dst_dir = File.dirname(dst)
    FileUtils.mkdir_p(dst_dir)

    src = "#{DOTFILES}/#{dir}/#{src}"
    File.symlink src, dst
    puts "symlink: #{dst} -> #{src}"
  end
end

unless /+ruby/ =~ `vim --version`
  puts "Install vim with ruby support"
else
  `cd #{HOME}/.vim/bundle/command-t && bundle install && rake make`
end
