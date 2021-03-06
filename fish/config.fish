set -gx EDITOR nvim

status --is-interactive; or exit

which -s rbenv; and source (rbenv init -|psub)
functions -q nvm; and setenv PATH (dirname (nvm which current)) $PATH

if test -z "$INSIDE_EMACS"; or test "$TERM" = dumb
  fish_vi_key_bindings
  set fish_cursor_default block
  set fish_cursor_insert line
  set fish_cursor_visual underscore
  set fish_cursor_unknown underscore
  fish_vi_cursor

  function -e fish_prompt __prompt_update_mode_info
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
      set -g      __fish_prompt_mode (string replace -a - _ $fish_bind_mode)
      eval set -g __fish_prompt_mode_color  \$fish_color_mode_$__fish_prompt_mode
      eval set -g __fish_prompt_mode_string \$__fish_mode_string__$__fish_prompt_mode
    end
  end
end

