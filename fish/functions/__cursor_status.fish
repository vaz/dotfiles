function __cursor_status -d "colour cursor based on status code of last command"
  set last_status $status
  if set -q argv[1]
    set last_status $argv[1]
  end
  if test -x (which it2_palette)
    if test $last_status = 0
      it2_palette cc $__fish_happy_cursor_colour
    else
      it2_palette cc $__fish_sad_cursor_colour
    end
  end
  return $last_status
end

