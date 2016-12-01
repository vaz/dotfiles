# ䷀ ䷁ ䷂ ䷃ ䷄ ䷅ ䷆ ䷇ ䷈ ䷉ ䷊ ䷋ ䷌ ䷍ ䷎ ䷏ ䷐ ䷑ ䷒ ䷓ ䷔ ䷕ ䷖ ䷗ ䷘ ䷙ ䷚ ䷛ ䷜ ䷝ ䷞ ䷟ 
#
# m.sh
#
# in the spirit of rupa deadwyler's z.sh
# by Vaz ䷣ 縷々2013年 under the WTFPL
# 
# Install:
#   - you can set $_M_CMD to change the command name (default b)
#   - you can set $_M_DATA to change the data file (default ~/.b)
#   - source this file in your .bashrc or .zsh
#         . /path/to/m.sh
#   - now bookmark some directories!
#
#
# Remark:
#   I have no idea if this actually works in zsh or any shell
#   other than bash.
#
# ䷠ ䷡ ䷢ ䷣ ䷤ ䷥ ䷦ ䷧ ䷨ ䷩ ䷪ ䷫ ䷬ ䷭ ䷮ ䷯ ䷰ ䷱ ䷲ ䷳ ䷴ ䷵ ䷶ ䷷ ䷸ ䷹ ䷺ ䷻ ䷼ ䷽ ䷾ ䷿ 

# TODO: fuzzy matching, tab completion


__m () {
  # usage instructions {{{

  local usage
  read -d '' usage <<EOF
Synopsis:
    m [-h] [--list]
    m [-s] [--add name[=path]] [--delete name] [name=[path]] ...
    m [-s] name

Options:
    -s|--follow             resolve symlinks when saving/jumping
    -a|--add name[=path]    path defaults to \$PWD
    -d|--delete name
    -h|--help               you're looking at it

Examples:
    m --add foo             bookmark current directory as 'foo'
    m -s --a tmp=/tmp       bookmark /tmp (resolves symlinks first) as 'tmp'
    m foo=.                 bookmark current directory as 'foo'

    m --delete etc          delete bookmark named 'etc'
    m foo=                  delete bookmark named 'foo'

    m foo                   jump to path bookmarked with name 'foo'
    m -s foo                jump to path resolving symlinks

    m --list                list bookmarks
    m                       list bookmarks

EOF

  # }}}
  # check data file {{{

  local fileheader="###m.sh-data###"
  local datafile="${_M_DATA:-$HOME/.m-data}"

  # if we don't own it, that's no good.
  [ -f "$datafile" -a ! -O "$datafile" ] && {
    echo "${_M_CMD:-m}: we don't own the data file $datafile" >&2; return 1
  }

  # quickly check if it appears to be the right file
  [ -f "$datafile" ] && [ "$(cat "$datafile")" != "" ] && {
    [ "$(head -n1 $datafile)" = "$fileheader" ] || {
      echo "${_M_CMD:-m}: file $datafile doesn't seem to be the data file" >&2
      return 1
    }
  } || {
    # initialize data file if it didn't exist or was empty
    echo "$fileheader" > "$datafile"
  }

  # }}}
  # parse arguments {{{

  local addlist deletelist
  declare -a addlist=( )
  declare -a deletelist=( )

  local list=yes follow= jump=

  while [ "$1" ]; do case "$1" in
    -h|--help)
      echo "$usage"; return ;;

    -s|--follow)
      follow='-P' ;;

    -a|--add)
      [ "$2" ] && { addlist+=( "$2" ); } || {
        echo "${_M_CMD:-m}: --add takes an argument" >&2; return 1
      }; shift ;;

    -d|--delete)
      [ "$2" ] && { deletelist+=( "$2" ); } || {
        echo "${_M_CMD:-m}: --delete takes an argument" >&2; return 1
      }; shift ;;

    -l|--list)
      list=yes ;;

    -*)
      echo "${_M_CMD:-m}: invalid option: $1" >&2 ;;

    *)
      local lhs=$(expr "$1" : "\(.*\)=")
      local rhs=$(expr "$1" : ".*=\(.*\)")

      [ "$lhs" ] && {
        [ "$rhs" ] && {
          addlist+=( "$1" )
        } || {
          deletelist+=( "$lhs" )
        }
      } || {
        [ -z "$jump" ] && { jump="$1"; } || { jump="$jump $1"; }
      } ;;
  esac; shift; done

  # }}}
  # jump {{{

  [ -n "$jump" ] && {
    # don't try to add stuff and jump at the same time
    (( ${#addlist[@]} + ${#deletelist[@]} )) && { echo "$usage"; return 1; }

    local target=$(grep -e "^$jump=" "$datafile" | cut -d= -f2)
    [ -z "$target" ] && {
      echo "${_M_CMD:-m}: no such bookmark: $jump"; return 1
    }
    cd "$target"
    return 0
  }
  # }}}
  # add {{{
  local arg

  for arg in ${addlist[@]}; do
    local name="$(echo "$arg" | cut -d= -f1)"
    local path="$(echo "$arg" | cut -d= -f2)"

    [ "$name" = "$path" ] && path=.

    [ ! -d "$path" ] && {
      echo "${_M_CMD:-m}: $path: no such directory"; return 1
    }

    # expand the path
    path=$(builtin cd "$path" 2>/dev/null; echo $(pwd $follow))

    local entry="$(grep -e "^$name=" "$datafile")"
    [ -z "$entry" ] && {
      echo "$name=$path" >> "$datafile"
    } || {
      sed -ie "s:^$name=.*$:$name=$path:" "$datafile"
    }
    list=no
  done

  # }}}
  # delete {{{

  for arg in ${deletelist[@]}; do
    # arg="$(echo $arg | cut -d= -f1)"
    sed -ie "/^$arg=/ d" "$datafile"
    list=no
  done

  # }}}
  # list {{{

  [ $list = yes ] && tail -n+2 "$datafile"
  return 0

  # }}}
}

alias ${_M_CMD:-m}='__m 2>&1'
