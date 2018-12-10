function fish_right_prompt
  set last_status $status
  if test -z "$INSIDE_EMACS"
    __cursor_status $last_status
    __fish_vcs_prompt
  end
end

