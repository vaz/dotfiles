# :: string utils :: {{{

isupper () { [[ "$1" =~ ^[[:upper:]] ]]; }
islower () { [[ "$1" =~ ^[[:lower:]] ]]; }

downcase () { echo -ne "$@" | tr '[:upper:]' '[:lower:]'; }
upcase () { echo -ne "$@" | tr '[:lower:]' '[:upper:]'; }

esc () { echo -ne '\033'"$@"; }

# length of args treated as a single token
len () { echo -n $(expr "$*" : '.*'); }

empty? () { [ "$1" = "" ]; }

# index of substring $1 in ${@:1} (rest)
indexof () {
  local needle="$1"; shift
  local haystack=' '"$*"
  local pos=$(len "${haystack%$needle*}")
  local r=$((pos % ${#haystack} - 1))
  (( r >= 0 )) && echo $r
}

# is string $1 contained in ${@:1} (rest) ?
includes? () { quietly indexof "$@"; }

# }}}
# :: colours :: {{{

# bold
@s () { [ -n "$TERM" ] && echo -n $(tput bold); }

# reverse
@S () { [ -n "$TERM" ] && echo -n $(tput rev); }

# underline
@u () { [ -n "$TERM" ] && echo -n $(tput smul); }

# underline off
@U () { [ -n "$TERM" ] && echo -n $(tput rmul); }

# reset
@x () { [ -n "$TERM" ] && echo -n $(tput sgr0); }

# TODO: use setaf/setab/etc;  see 'man terminfo'
_colour () {
  esc "[${1}m"; shift
  (( $# )) && {
    echo -n "$@"
    @x
  }
}

@ () {
  [[ $1 = [sSuUx] ]] && { eval "@$1 $@"; return; }
  local codes='krgybmcwKRGYBMCW' c="${1:0:1}"
  local s="$1"; c="${s:0:1}"
  local f=setaf out=''
  shift

  while [[ "$c" = [+_~-] ]]; do
    [ "$c" = '+' ] && { out+="$(tput bold)"; }
    [ "$c" = '-' ] && { f=setab; }
    [ "$c" = '_' ] && { out+="$(tput smul)"; }
    [ "$c" = '~' ] && { out+="$(tput rev)"; }
    s="${s:1}"; c="${s:0:1}"
  done

  debug $c
  local i=$(indexof "$c" "$codes")

  #debug $b $((i+30)) "$@"
  out+="$(tput $f $i)"
  echo -n "$out"
  #_colour $b\;$((i+30)) "$@"
}

# todo: permutations of + - _ ~
for _c in k r g y b m c w K R G Y B M C W; do
  eval "@$_c () { @ $_c \"\$@\" ; }"
done
unset _c _C

listcolours () {
  for ((i=0; i<=7; i++)); do
    echo -e "\033[0;3${i}m0;3$i \033[0;9${i}m0;9$i \033[1;3${i}m1;3$i \033[1;9${i}m1;9$i \033[0;4${i}m0;4$i\033[0m \033[1;4${i}m1;4$i\033[0m \033[0;10${i}m0;10$i\033[0m \033[1;10${i}m1;10$i\033[0m \033[3;3${i}m3;3${i}\033[0m \033[3;9${i}m3;9$i\033[0m \033[1;3;3${i}m1;3;3$i\033[0m \033[1;3;9${i}m1;3;9$i\033[0m \033[4;3${i}m4;3$i\033[0m \033[4;9${i}m4;9$i\033[0m \033[1;4;3${i}m1;4;3$i\033[0m"
  done
}

#}}}
