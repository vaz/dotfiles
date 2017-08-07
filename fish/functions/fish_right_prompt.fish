function fish_right_prompt
  if test -z "$INSIDE_EMACS"
    __cursor_status
    __fish_vcs_prompt
  end
end

