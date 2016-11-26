function fish_mode_prompt --description 'Displays the current mode'
	# Do nothing if not in vi mode
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    set -g __fish_prompt_mode (string replace -a - _ $fish_bind_mode)
    eval set -g __fish_prompt_mode_color \$fish_color_mode_$__fish_prompt_mode
    eval set -g __fish_prompt_mode_string \$__fish_mode_string__$__fish_prompt_mode
    set -g ___fish_git_prompt_color_branch (set_color $__fish_prompt_mode_color)
    # set_color --bold 303030 --background $__fish_prompt_mode_color
    # echo -n -s $__fish_prompt_mode_string ' '
    # set_color normal
    # set_color $__fish_prompt_mode_color --background 303030
    # echo -n -s $__fish_prompt_left_sep ' '
  end
end
