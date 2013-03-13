# filesystem detection
darwin () { [ "`uname`" = "Darwin" ]; }
linux () {  [ "`uname`" = "Linux"  ]; }

not () { "$@"; return $(( ! $? )); }

truthy? () { none? '[ "$1" = "'"$(downcase "$1")"'" ]' false no off f n 0; }

is? () { not empty? "$1" && { (( "$1" )) || truthy? "$1"; }; }

# warn and die
warn () { echo "$@" >&2; }
debug () { is? "$DEBUG" && warn "$@"; }
die () { warn "$@" && exit; }

# print last exit code
? (){ echo $?; }

# readable way to ignore output
quietly () { "$@" >/dev/null; }
alias q='quietly '

# readable way to ignore output and error
silently () { "$@" >/dev/null 2>&1; }
alias qq='silently '

# readable way to ignore errors
try () { "$@" 2>/dev/null; }

# otherwise allows for some more readable constructions
otherwise () { [ $? = 0 ] || "$@"; }

# eval $1 as the body of an anonymous function, and invoke it
# passing the remaining arguments
proc () {
  : ${1?"Usage: $FUNCNAME functionbody [args...]"}
  local __f
  eval '__f(){' "$1" '; }'
  __f "${@:2}"
}

each () {
  local cmd="$1"; shift
  for arg; do
    "$1" "$arg"
  done
}

all? () {
  local f="$1"; shift
  for arg; do proc "$f" "$arg" || return 1; done
  return 0
}

# 
not-all? () {
  local f="$1"; shift
  for arg; do proc "$f" "$arg" || return 0; done
  return 1
}

any? () {
  local f="$1"; shift
  for arg; do proc "$f" "$arg" && return 0; done
  return 1
}

none? () {
  local f="$1"; shift
  for arg; do proc "$f" "$arg" && return 1; done
  return 0;
}

# returns numerical max of all args
max () {
  local m="$1"
  for arg; do (("$arg" > "$m")) && m="$arg"; done
  echo "$m"
}

# returns numerical min of all args
min () {
  local m="$1"
  for arg; do (("$arg" > "$m")) && m="$arg"; done
  echo "$m"
}

# usage:  slice n..m args...
# echoes args n to m
# indexes are 1-based, to match positional argument numbers
# a negative n or m counts from the end, so -1 is the last argument
# n.. is equivalent to n..-1
# ..m is equivalent to 1..m
# n is equivalent to n..n (a single argument)
# invalid slices will echo nothing
slice () {
  local range="$1"; shift
  local n="${range%..*}"; n=${n:-0}
  local m="${range#*..}"; m=${m:-$#}

  # normalize negatives
  (( $n < 0 )) && n=$(($# + n + 1))
  (( $m < 0 )) && m=$(($# + m + 1))

  # limit range
  n=$(max $n 1)
  m=$(min $m $#)

  local d=$((m - n + 1))
  (( $d > 0 )) && echo "${@: $n: $d}"
}

forfiles () {
  find . -iname "$1" -print0 | xargs -0 "${@:2}"
}

/   () { pcregrep --colour     $*; }
/i  () { pcregrep --colour -i  $*; }
/r  () { pcregrep --colour -r  $*; }
/ir () { pcregrep --colour -ir $*; }


alias back='quietly popd'
alias fd='quietly pushd'

__cd () {
  [ -z "$1" ] && { [ "$PWD" = "$HOME" ] || silently pushd "$HOME"; return; }
  silently pushd "$@"
  otherwise try _z "$@"
  otherwise builtin cd "$@"
  _z --add $(pwd -P 2>/dev/null) 2>/dev/null
}
alias cd='__cd'

# activate $1, a virtualenv (python)
activate () { . "$1/bin/activate"; }


vundle-upgrade () { vim +BundleInstall! +BundleClean +q +q /dev/zero; }

vundle-get () {
  sed -i.bak -Ee 's#^(" ::bundle tail::)#Bundle '"'$1'"'\'$'\n''\1#' ~/.vimrc
  vundle-upgrade
}



# start mongod in the context of virtualenv $1 (python)
mongod-env () {
  [[ -d "$1" && -f "$1/bin/activate" ]] && {
    mkdir -p $1/var/{data,log,run}
    mongod --fork --logappend\
           --dbpath="$1/var/data/"\
           --logpath="$1/var/log/mongodb.log"\
           --pidfilepath="$/var/run/mongod.pid"
  } || {
    echo "Doesn't seem to be a virtualenv."
  }
}

# show gcc's assembly output for the given source file or string
showasm () {
  : ${1?"Usage: $FUNCAME [gcc-options] <file|string>"}

  local src="${@: -1}"
  local opts=$(slice ..-2 "$@")
  local cc="${CC:-gcc}"
  local cmd="$cc -x c -S -o - $opts "

  [ -f "$src" ] && {
    "$cmd" "$src"
  } || {
    echo "$@" | $cmd -
  }
}


if [ "`uname`" = "Darwin" ]; then
  function showAllFiles {
    local new old=`defaults read com.apple.finder AppleShowAllFiles`
    if [ "$old" = "TRUE" ]; then
      new="FALSE"
    else
      new="TRUE"
    fi

    defaults write com.apple.finder AppleShowAllFiles $new
    echo -n "com.apple.finder AppleShowAllFiles = "
    echo $new
    killall Finder
  }
fi
