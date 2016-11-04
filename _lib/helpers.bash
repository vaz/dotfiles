
function abspath {
  local d="$(dirname "$1")"
  (cd "$d" &>/dev/null &&
    echo "${PWD}/$(basename "$1")" ||
    echo >&2 "$0: directory '$d' does not exist")
}
