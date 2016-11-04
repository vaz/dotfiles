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

# eval args or stdin as the body of an anonymous utility and return the
# utility
proc () {
  local body
  [[ $# > 0 && "$1" != '-' ]] && body="$*" || body="$(cat -)"
  local sum="$(echo "$body" | shasum | cut -d' ' -f1)"
  mkdir -p /tmp/_fproc_cache
  local f=/tmp/_fproc_cache/proc-$sum
  [ -e $f ] && { echo $f; return; }
  echo "$body" > "$f"
  chmod u+x $f
  echo "$f"
}

each () {
  xargs -I{} -L1 "$@"
}

enum () { for arg; do echo "$arg"; done; }

repeat () { seq 1 $1 | each "${@:2}"; }

cycle () {
  if [[ $# = 0 || $1 = - ]]; then
    set -- $(IFS=; while read arg; do echo -n "$arg "; done)
  fi
  yes "enum \"$@\"" | $BASH
}

all? () {
  each $(proc "$*") {} || return 1
  return 0
}

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


#alias back='quietly popd'
#alias fd='quietly pushd'
#
#__cd () {
#  [ -z "$1" ] && { [ "$PWD" = "$HOME" ] || silently pushd "$HOME"; return; }
#  silently pushd "$@" && _z --add $(pwd -P 2>/dev/null) 2>/dev/null
#  otherwise try _z "$@"
#  otherwise builtin cd "$@" && _z --add $(pwd -P 2>/dev/null) 2>/dev/null
#}
#alias cd='__cd'
#
#zr () {
#  local reporoot=$(git rev-parse --show-toplevel 2>/dev/null)
#  z $reporoot $@
#}

# activate $1, a virtualenv (python)
activate () { . "$1/bin/activate"; }

# TODO: vundle should really have a CLI client, and maybe have its own file
# that is included by vimrc, added to automatically by the cli client and
# can contain the per-plugin settings.  Or a directory with one file per
# plugin.

vundle-upgrade () { vim +BundleInstall! +BundleClean +q +q /dev/zero; }

vundle-get () {
  sed -i.bak -Ee 's#^(" ::bundle tail::)#Bundle '"'$1'"'\'$'\n''\1#' ~/.vimrc
  vundle-upgrade
}

full-env () { comm -3 <(declare | sort) <(declare -f | sort); }


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


# iTerm2 custom control sequences:

# set the tab's background colour
it2_settabbg () {
  local fmt=$'\033]6;1;bg;%s;brightness;%d\a'
  printf "$fmt$fmt$fmt" red $1 green $2 blue $3
}

it2_palette () {
  local fmt=$'\033]P%c%s\033\\'

  local ts="
  g foreground fg
  h background bg
  i bold
  j selection sbg sb
  k selected-text selected sfg sf
  l cursor cc
  m cursor-text ct
"
  (( $# < 2 )) || case "$1" in -h|--help)
    echo "$0 target ffffff"; (IFS=; echo $ts) ;; esac

  while (( $# )); do
    (( $# >= 2 )) || { echo "Missing colour argument for $1"; break; }
    local t="$1" c="$2"; shift 2

    # convert decimal to hex if it's a number
    if (( "$t" )); then
      t=$(printf "%x" $t)
    else
      t=$((IFS=; echo $ts) | perl -ne '/\b(\w)\b.*\b'"$t"'\b/ and print $1')
    fi

    printf "$fmt" $t "$c"
  done
}

