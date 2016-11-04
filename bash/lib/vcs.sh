
# fastest one :)
__hgdir () {
  (
    [ -n "$1" ] && builtin cd "$1"
    builtin cd "$(pwd -P)"
    until false; do
      [ -d .hg ] && {
        echo "$PWD/.hg"
        break
      }
      [ "$PWD" = "/" ] && return 1
      builtin cd ..
    done
  )
}

# display branch and bookmark for hg in prompt
__hg_prompt () {
  # hg is so slow
  # I'm giving up on being able to see if it's dirty or not
  # we can grab the branch and bookmark easily without invoking hg
  local hgdir="$(__hgdir)"
  [ -n "$hgdir" ] || return

  local branch=$(cat "$hgdir"/branch)
  local bookmark=
  [ -f "$hgdir"/bookmarks.current ] && {
    bookmark=$(cat "$hgdir"/bookmarks.current)
  }
  echo -ne "`@b` on `@B`$branch`@`"
  [ -n "$bookmark" ] && echo -ne "`@b` at `@B`$bookmark`@`"
}

# display branch and status char for git in prompt
__git_prompt () {
  local st="$(git status --porcelain 2>/dev/null)"

  local x="$(echo "$st" | cut -b1)"
  local y="$(echo "$st" | cut -b2)"

  local chr=''
  local az='[A-Z]' q='\?'

  [[ "$x" =~ $q  ]] && chr+='?'
  [[ "$x" =~ $az ]] && chr+='!'
  [[ "$y" =~ $az ]] && chr+='*'

  __git_ps1 "\e[0;34m on \e[1;34m%s\e[0;32m${chr}\e[0m"
}


__prompt_char () {
  git branch >/dev/null 2>&1 && echo '±' && return
  __hgdir    >/dev/null 2>&1 && echo '☿' && return
  echo '$'
  # Ȣ ȣ  ʢʡ  μ  ☿
}


export -f __hgdir
export -f __hg_prompt
export -f __git_prompt
export -f __prompt_char


###############################################################################
# old stuff

# u  3  9
# s  8 30
hgdir_cdrecursive () {
    local dir="${1:-$PWD}"
    #dir=$(cd $dir; pwd -P)

    [ -d "$dir/.hg" ] && { 
        echo "$dir/.hg";
        return
    };
    [ "$dir" = "/" ] && return 1;
    ( builtin cd ..; hgdir_cdrecursive )
}

# r  3  7
# s  5 16
hgdir_recursive () {
    local dir="${1:-$PWD}"
    #dir=$(cd $dir; pwd -P)

    [ -d "$dir/.hg" ] && { 
        echo "$dir/.hg";
        return
    };
    [ "$dir" = "/" ] && return 1;
    hgdir_recursive $(dirname "$dir")
}

# r  2 4
# s  5 14
hgdir_loop () {
    local dir="${1:-$PWD}"
    #dir=$(cd $dir && pwd -P)

    until false; do
        [ -d "$dir/.hg" ] && { 
            echo "$dir"/.hg;
            break
        };
        [ "$dir" = "/" ] && return 1;
        dir="$(dirname $dir)";
    done
}

__old_hg_prompt () {
  echo -e $(hg prompt "\
{\033[0m on \033[0;35m{branch}}\
{\033[0m at \033[0;34m{bookmark}}\
{\033[0;32m{status}}{\033[0;32m{update}}\
\033[0m" 2>/dev/null)
}
