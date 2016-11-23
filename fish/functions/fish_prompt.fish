function fish_prompt --description 'Write out the prompt'
	# Just calculate this once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

	set -l suffix
	switch $USER
	case root toor
		set suffix '#'
	case '*'
		set suffix ''
	end

	echo -n -s (set_color 303030 -b $__fish_prompt_mode_color) "$USER" @ "$__fish_prompt_hostname" ' ' (set_color $__fish_prompt_mode_color -b 303030) $__fish_prompt_left_sep ' ' (prompt_pwd) ' ' (set_color 303030 -b normal) $__fish_prompt_left_sep ' ' (set_color normal)
end
