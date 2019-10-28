function fish_user_key_bindings --description 'autoloaded, bind should go here'
  # run git status quickly
  bind \e\; __fish_run_git_status
  bind -M insert \e\; __fish_run_git_status

  # C-l (clear) + M-l (ls)
  bind -M insert \eL 'clear; echo -e "ls" (pwd)":\n"; ls; commandline -f repaint'

  # history search
  bind -M insert \e\[1\;5A history-search-backward
  bind -M insert \e\[1\;5B history-search-forward
  bind -M insert \cp history-search-backward
  bind -M insert \cn history-search-forward
end
