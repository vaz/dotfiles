# filesystem detection
darwin(){ [ "`uname`" = "Darwin" ]; }
linux(){  [ "`uname`" = "Linux"  ]; }

# warn and die
warn(){ echo "$@" >&2; }
die(){ warn "$@" && exit; }

# print last exit code
? (){ echo $?; }

# readable way to ignore output
quietly(){ "$@" >/dev/null; }
alias q='quietly '

# readable way to ignore output and error
silently(){ "$@" >/dev/null 2>&1; }
alias qq='silently '

# readable way to ignore errors
try(){ "$@" 2>/dev/null; }

# otherwise allows for some more readable constructions
otherwise () { [ $? = 0 ] || "$@"; }

# eval $1 as the body of an anonymous function, and invoke it
# passing the remaining arguments
proc(){
  : ${1?"Usage: $FUNCNAME functionbody [args...]"}
  local __f
  eval '__f(){' "$1" '; }'
  __f "${@:2}"
}

# returns numerical max of all args
max(){
  local m="$1"
  for arg; do (("$arg" > "$m")) && m="$arg"; done
  echo "$m"
}

# returns numerical min of all args
min(){
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
slice(){
  local range="$1"; shift
  local n="${range%..*}"; n=${n:-0}
  local m="${range#*..}"; m=${m:-$#}

  # normalize negatives
  (( $n < 0 )) && n=$(($# + n + 1))
  (( $m < 0 )) && m=$(($# + m + 1))

  # limit range
  (( $n < 1 )) && n=1
  (( $m > $# )) && m=$#

  local d=$((m - n + 1))
  (( $d > 0 )) && echo "${@: $n: $d}"
}

function listcolours {
  for ((i=0; i<=7; i++)); do
    echo -e "\033[0;3${i}m0;3$i \033[1;3${i}m1;3$i \033[0;4${i}m0;4$i \033[0m"
  done
}

function forfiles {
  find . -iname "$1" -print0 | xargs -0 "${@:2}"
}

function /   { pcregrep --colour     $*; }
function /i  { pcregrep --colour -i  $*; }
function /r  { pcregrep --colour -r  $*; }
function /ir { pcregrep --colour -ir $*; }


alias back='quietly popd'
alias fd='quietly pushd'

function __cd {
  [ -z "$1" ] && { [ "$PWD" = "$HOME" ] || silently pushd "$HOME"; return; }
  silently pushd "$@"
  otherwise try _z "$@"
  otherwise builtin cd "$@"
}
alias cd='__cd '

# activate $1, a virtualenv (python)
activate(){ . "$1/bin/activate"; }

# start mongod in the context of virtualenv $1 (python)
mongod-env(){
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
function showasm {
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
