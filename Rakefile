require 'rubygems'
require 'rake'
require 'fileutils'


include FileUtils

HOME = ENV['HOME']
DOTFILES = File.expand_path(File.dirname(__FILE__))
UNAME = `uname`.chomp

def mac?; UNAME == 'Darwin' end
def linux?; UNAME == 'Linux' end

(puts "What system are you on, anyway?"; exit) unless mac? or linux?

def has? cmd; `which #{cmd}` and $? == 0 end
def missing? cmd; not has?(cmd) end

def pkginstall aptname, brewname = nil
  brewname = aptname if brewname.nil?
  if linux?
    print "Installing #{aptname}... "
    r = `sudo apt-get install -y #{aptname}`
  elsif mac?
    print "Installing #{brewname}... "
    r = `brew install #{brewname}`
  end
  $? != 0 ? (puts r)
          : (puts "done."; true)
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
  mapping.each do |rmt, path|
    if File.exists? path
      print "hg: updating #{path}..."
      r = `(cd #{path} && HGRCPATH='' hg pull --update 2>/dev/null)`
      $? != 0 ? (puts r)
              : (puts "done." ; true)
    else
      rmt = "https://bitbucket.org/#{rmt}" if rmt.match(%r{^[\w-]+/[\w-]+$})
      print "hg: cloning #{rmt} into #{path}..."
      r = `HGRCPATH='' hg clone --insecure #{rmt} #{path} 2>/dev/null`
      $? != 0 ? (puts r)
              : (puts "done." ; true)
    end
  end
end


task :default => [:vim, :screen, :bash, :bin, :ack]


task :brew do
  if mac? and missing? 'brew'
    puts "Installing brew..."
    `/usr/bin/ruby -e "$(/usr/bin/curl -fksSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"`
    puts "Done."
  end
end

task :git => :brew do
  pkginstall "git-core", "git" unless has?('git')
  dotfiles 'git', 'gitconfig' => '.gitconfig',
                  'gitignore' => '.gitignore'
end

task :bash => :git do
  pkginstall 'bash-completion'
  dotfiles 'bash',  "bashrc.#{UNAME}" => '.bashrc',
                    "bash_aliases"    => '.bash_aliases',
                    "bash_defs"       => '.bash_defs',
                    "profile"         => '.profile'
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
  `(cd #{DOTFILES}/hg;
    echo '#{genheader}' | cat - hgrc hgrc.#{UNAME} > hgrc.local)`

  dotfiles 'hg', "hgrc.local" => '.hgrc'

  hgext = "#{DOTFILES}/hg/ext"

  mkdir_p hgext

  hgclone 'sjl/hg-prompt' => "#{hgext}/prompt"
  hgclone 'pk11/mercurial-extensions-localbranch' => "#{hgext}/localbranch"
  hgclone 'yinwm/hgflow' => "#{hgext}/flow"
end

task :ruby => :git do
  dotfiles 'ruby',  'irbrc'     => '.irbrc',
                    'pryrc'     => '.pryrc',
                    'bundle'    => '.bundle'

  if missing? 'rbenv' or /^ruby 1.9/ !~ `ruby -v`
    puts "Installing ruby with rbenv..."
    r = `#{DOTFILES}/ruby/setup.sh`
    puts r unless $? == 0
  end
end

task :screen do
  dotfiles 'screen', 'screenrc' => '.screenrc'
end

task :vim => [:hg, :ruby] do
  dotfiles 'vim', 'vimrc'   => '.vimrc',
                  'vimhome' => '.vim'

  unless /\+ruby/ =~ `vim --version`
    pkginstall "libncurses5-dev libxml2-dev libxslt1-dev ruby1.8-dev" if linux?
    puts "Compiling a vim that doesn't suck..."
    r = `#{DOTFILES}/vim/compile-vim.sh`
    puts r unless $? == 0
  end

  system "vim +BundleInstall! +BundleClean +q +q /dev/zero"
  system "cd #{HOME}/.vim/bundle/command-t && bundle install && rake make"
  system "source #{HOME}/.bashrc"
end


