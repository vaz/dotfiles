# TODO: some good python
# This is all fucked up.
#
require 'rubygems'
require 'rake'
require 'fileutils'

include FileUtils


HOME      = ENV['HOME']
DOTFILES  = File.expand_path(File.dirname(__FILE__))
PLATFORM  = `uname`.chomp.downcase

def mac?;   PLATFORM =~ /darwin/ end
def linux?; PLATFORM =~ /linux/  end

module Tty extend self
  def escape n; "\033[#{n}m" if STDOUT.tty? end
  def reset; escape 0; end
  def bold n; escape "1;#{n}" end
  def underline n; escape "4;#{n}" end
end

module Colourized
  TAGS = %w(k r g y b m c w)
  VALUES = (30..37).to_a
  PAIRS = TAGS.zip(VALUES)

  def coloured
    self # TODO
  end
end

def invoke task; Rake::Task[task].invoke end


mac? or linux? or abort "since when do you use #{PLATFORM}? peace out."

def has?     cmd; system "which -s #{cmd}" end
def missing? cmd; not has?(cmd) end

def quietly  cmd; system "#{cmd} >/dev/null 2>&1" end

def ok? desc, r
  print "#{desc}... "
  $?.success? ? puts('done.') : puts(r)
  $?.success?
end

def pkginstall name, brewname=nil
  cmd = 'sudo apt-get install -y'
  if mac?
    cmd = 'brew install'
    name = brewname or name
  end
  ok? "installing #{name}",
      `#{cmd} #{name}`
end

def genheader prefix='#'
  "#{prefix} this file is generated, make your edits elsewhere!\n\n"
end

def dotfiles type, mapping={}
  mapping.each do |src, dst|
    src = File.join(DOTFILES, type, src)
    dst = File.join(HOME, dst) unless dst.start_with? '/'
    bak_dir = File.join(HOME, ".backups")
    mkdir_p bak_dir

    if File.exists? dst or File.symlink? dst
      if File.symlink? dst
        puts "delete:  #{dst}"
        File.directory?(dst) ? rm_rf(dst) : File.delete(dst)
      else
        bak = File.join(bak_dir, basename(dst))
        puts "backup:  #{dst} to #{bak}"
        File.rename dst, bak
      end
    end

    puts "symlink: #{dst} -> #{src}"
    symlink src, dst
  end
end

def hgclone mapping={}
  mapping.each do |r, path|
    if File.exists? path
      ok? "hg: updating #{path}",
          `(cd #{path} && HGRCPATH='' hg pull --update 2>/dev/null)`
    else
      r = "https://bitbucket.org/#{r}" if r =~ /^[\w-]+\/[\w-]+$/
      ok? "hg: cloning #{r} into #{path}",
          `HGRCPATH='' hg clone --insecure #{r} #{path} 2>/dev/null`
    end
  end
end


task :default => [:vim, :screen, :bash, :bin, :ack]


task :brew do
  if mac? and missing? 'brew'
    ok? "installing brew",
        `$0 -e "$(/usr/bin/curl -fksSL raw.github.com/mxcl/homebrew/go)"`
  end
end

task :git => :brew do
  pkginstall "git-core", "git" unless has? 'git'
  dotfiles 'git', 'gitconfig' => '.gitconfig',
                  'gitignore' => '.gitignore'
end

task :bash => :git do
  pkginstall 'bash-completion'
  dotfiles 'bash',  "bashrc" => '.bashrc',
                    "lib" => '.sh'
  dotfiles 'bash',  "profile" => '.profile' if mac?
end

task :ack => :brew do
  pkginstall 'ack'
  dotfiles 'ack', 'ackrc' => '.ackrc'
end


directory "#{HOME}/bin"
task :bin => "#{HOME}/bin" do
  dotfiles 'bin', 'z.sh' => 'bin/z.sh'
end

task :hg do
  hg = "#{DOTFILES}/hg"
  `(cd "#{hg}"; echo '#{genheader}' | cat - hgrc hgrc.#{PLATFORM} >hgrc.local)`

  dotfiles 'hg', "hgrc.local" => '.hgrc'

  hgext = (mkdir_p "#{hg}/ext").first

  hgclone 'sjl/hg-prompt' => "#{hgext}/prompt"
  hgclone 'pk11/mercurial-extensions-localbranch' => "#{hgext}/localbranch"
  hgclone 'yinwm/hgflow' => "#{hgext}/flow"
end

task :ruby => :git do
  dotfiles 'ruby',  'irbrc'     => '.irbrc',
                    'pryrc'     => '.pryrc',
                    'bundle'    => '.bundle'

  puts "Installing ruby with rbenv..."
  system "#{DOTFILES}/ruby/install-ruby.sh"
end

task :screen do
  dotfiles 'screen', 'screenrc' => '.screenrc'
end

task :vim => [:hg, :ruby] do
  dotfiles 'vim', 'vimrc'   => '.vimrc',
                  'vimhome' => '.vim'

  unless /\+ruby/ =~ `vim --version`
    %w(libncurses5-dev libxml2-dev libxslt1-dev ruby1.8-dev).map |pkg| do
      pkginstall pkg
    end if linux?
    puts "Compiling a vim that doesn't suck..."
    r = `#{DOTFILES}/vim/compile-vim.sh`
    puts r unless $? == 0
  end

  system "vim +BundleInstall! +BundleClean +q +q /dev/zero"
  system "cd #{HOME}/.vim/bundle/command-t && bundle install && rake make"
  system "source #{HOME}/.bashrc"
end
