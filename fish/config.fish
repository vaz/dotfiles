set -gx EDITOR nvim
whether hub; and alias git=hub

if status --is-interactive
  . (rbenv init -|psub)
else
  exit
end

if test -z "$INSIDE_EMACS" -o "$TERM" = dumb
  fish_vi_key_bindings
  set fish_cursor_default block
  set fish_cursor_insert line
  set fish_cursor_visual underscore
  set fish_cursor_unknown underscore
  fish_vi_cursor

  bind -M insert \e\[1\;5A history-search-backward
  bind -M insert \e\[1\;5B history-search-forward
  bind -M insert \cp history-search-backward
  bind -M insert \cn history-search-forward

  function -e fish_prompt __prompt_update_mode_info
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
      set -g      __fish_prompt_mode (string replace -a - _ $fish_bind_mode)
      eval set -g __fish_prompt_mode_color  \$fish_color_mode_$__fish_prompt_mode
      eval set -g __fish_prompt_mode_string \$__fish_mode_string__$__fish_prompt_mode
    end
  end
end


