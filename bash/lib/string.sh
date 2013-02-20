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
@s () { echo -n $(tput bold); }

# underline
@u () { echo -n $(tput smul); }

# underline off
@U () { echo -n $(tput rmul); }

# reset
@x () { echo -n $(tput sgr0); }

_colour () {
  esc "[$1;$2m"; shift 2
  (( $# )) && {
    echo -n "$@"
    @x
  }
}

@ () {
  [[ $1 = [suUx] ]] && { eval "@$1 $@"; return; }
  local codes='krgybmcwKRGYBMCW' b=0 c="${1:0:1}" bg=0
  shift

  [ "$c" = "-" ] && { bg=1; c="${1:1:1}"; } || { isupper $c && b=1; }

  debug $c
  # modulo to ignore case:
  local i=$(indexof "$c" "$codes")
  i=$(expr $i % 8)

  debug $b $((i+30)) "$@"
  _colour $b $((i+30)) "$@"
}

for _c in k r g y b m c w K R G Y B M C W -k -r -g -y -b -m -c -w; do
  eval "@$_c(){ @ $_c \"\$@\" ; }"
done
unset _c _C

listcolours () {
  for ((i=0; i<=7; i++)); do
    echo -e "\033[0;3${i}m0;3$i \033[1;3${i}m1;3$i \033[0;4${i}m0;4$i \033[0m"
  done
}

#}}}
