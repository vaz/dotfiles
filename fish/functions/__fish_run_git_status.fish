function __fish_run_git_status --description 'run git status, for use in a key binding'
  if not set -q fish_git_status_cmd
    set -U fish_git_status_cmd "git status"
  end
  echo
  eval $fish_git_status_cmd
  commandline -f repaint
end
