# :: string utils :: {{{

isupper(){ [[ "$1" =~ ^[[:upper:]] ]]; }
islower(){ [[ "$1" =~ ^[[:lower:]] ]]; }

downcase(){ echo -ne "$@" | tr '[:upper:]' '[:lower:]'; }
upcase(){ echo -ne "$@" | tr '[:lower:]' '[:upper:]'; }

esc(){ echo -ne '\033'"$@"; }

# length of args treated as a single token
len(){ echo -n $(expr "$*" : '.*'); }

# index of substring $1 in target $2
indexof(){
  local target=' '"$2"
  local pos=$(len "${target%$1*}")
  echo -n $((pos % ${#target} - 1))
}

# }}}
# :: colours :: {{{

# bold
@s (){ echo -n $(tput bold); }

# underline
@u (){ echo -n $(tput smul); }

# underline off
@U(){ echo -n $(tput rmul); }

# reset
@x (){ echo -n $(tput sgr0); }

_colour(){
  esc "[$1;$2m"; shift 2
  (( $# )) && {
    echo -n "$@"
    @x
  }
}

@ (){
  [[ $1 = [suUx] ]] && { eval "@$1 $@"; return; }
  local codes='krgybmcwKRGYBMCW' b=0 c="${1:0:1}"
  shift

  isupper $c && b=1

  # modulo to ignore case:
  local i=$(expr $(indexof "$c" "$codes") % 8)

  _colour $b $((i+30)) "$@"
}

for _c in k r g y b m c w K R G Y B M C W; do
  eval "@$_c(){ @ $_c \"\$@\" ; }"
done
unset _c _C

#}}}
