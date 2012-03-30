#!/usr/bin/env ruby

require 'fileutils'

if `which git` and $? != 0
  puts "Please install git."
  exit
end

deps = %w(libncurses5-dev libxml2 libxml2-dev libxslt1-dev ruby1.8-dev)
system "which apt-get >/dev/null 2>&1 && sudo apt-get install -y #{deps.join ' '}"

puts "You probably want to install bash-completion" if `which __git_ps1` and $? != 0

flags = ARGV[1,1000].join

if flags.include? 'f'
  puts "Not creating backups!"
  destructive = true
end

if flags.include? 's'
  puts "Forcing use of sudo"
  sudo = true
end

HOME = ENV['HOME']
DOTFILES = File.expand_path(File.dirname(__FILE__))

uname = `uname`.chomp

dotfiles = {
  'bash' => {
    "bashrc.#{uname}" => "#{HOME}/.bashrc",
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
    "hgrc.#{uname}"   => "#{HOME}/.hgrc"
  },
  'ruby' => {
    "autotest"        => "#{HOME}/.autotest",
    "irbrc"           => "#{HOME}/.irbrc",
    "pryrc"           => "#{HOME}/.pryrc",
    "bundle"          => "#{HOME}/.bundle"
  },
  'screen' => {
    "screenrc"        => "#{HOME}/.screenrc"
  },
  'vim' => {
    "vimrc"           => "#{HOME}/.vimrc",
    "vimhome"         => "#{HOME}/.vim"
  }
}

if not destructive
  backups_dir = "#{HOME}/.backups"
  FileUtils.mkdir_p backups_dir
end

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
        bak = "#{backups_dir}/#{File.basename dst}"
        puts "backup:  #{dst} to #{bak}"
        File.rename(dst, "#{bak}")
      end
    end

    dst_dir = File.dirname(dst)
    FileUtils.mkdir_p(dst_dir)

    src = "#{DOTFILES}/#{dir}/#{src}"
    File.symlink src, dst
    puts "symlink: #{dst} -> #{src}"
  end
end

unless /\+ruby/ =~ `vim --version`
  puts "Compiling a vim that doesn't suck..."
  system "#{DOTFILES}/vim/compile-vim.sh"
end

sudo ||= `which rbenv` && $?.success?
puts "rbenv exists so assuming no sudo needed" unless sudo

system "#{sudo ? 'sudo' : ''} gem install bundler --no-rdoc --no-ri"

system "git clone https://github.com/gmarik/vundle.git #{DOTFILES}/vim/vimhome/bundle/vundle"

system "vim +BundleInstall! +BundleClean +qall /dev/zero"

system "cd #{HOME}/.vim/bundle/command-t && bundle install && rake make"
