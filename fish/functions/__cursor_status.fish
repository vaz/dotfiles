function -e fish_prompt __cursor_status
  set -l last_status $status
  if test -x (which it2_palette)
    if test $last_status = 0
      it2_palette cc $__fish_happy_cursor_colour
    else
      it2_palette cc $__fish_sad_cursor_colour
    end
  end
  return $last_status
end

