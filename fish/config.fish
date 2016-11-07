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

set -gx EDITOR nvim

alias ipinfo='curl ipinfo'

if whether hub
  alias git=hub
end

status --is-interactive; and . (rbenv init -|psub)

function -e fish_prompt __cursor_status
  set -l last_status $status
  if test -x (which it2_palette)
    if test $last_status = 0
      it2_palette cc 99ffa8
    else
      it2_palette cc ff88aa
    end
  end
  return $last_status
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
