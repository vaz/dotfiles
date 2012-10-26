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
  if $? != 0
    puts r
  else
    puts "Done." and true
  end
end

def dotfiles type, mapping={}
  mapping.each do |src, dst|
    src = File.join(DOTFILES, type, src)
    dst = File.join(HOME, dst) unless dst.start_with? '/'
    bak_dir = File.join(HOME, ".backups")
    FileUtils.mkdir_p bak_dir

    if File.exists? dst or File.symlink? dst
      if File.symlink? dst
        puts "delete:  #{dst}"
        File.directory?(dst) ? FileUtils.rm_rf(dst) : File.delete(dst)
      else
        bak = File.join(bak_dir, basename(dst))
        puts "backup:  #{dst} to #{bak}"
        File.rename dst, bak
      end
    end

    puts "symlink: #{dst} -> #{src}"
    FileUtils.symlink src, dst
  end
end

task :default => [:vim, :screen, :bash, :bin]


task :brew do
  if mac? and missing? 'brew'
    puts "Installing brew..."
    `/usr/bin/ruby -e "$(/usr/bin/curl -fksSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"`
    puts "Done."
  end
end

task :git => :brew do
  pkginstall "git-core", "git" unless has?('git')
  dotfiles 'git', 'gitconfig' => '.gitconfig'
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
end


directory "#{HOME}/bin"
task :bin => "#{HOME}/bin" do
  dotfiles 'bin', 'z.sh' => 'bin/z.sh'
end

task :hg do
  dotfiles 'hg', "hgrc.#{UNAME}" => '.hgrc'
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


