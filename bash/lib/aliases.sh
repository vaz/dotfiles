# Vaz's bash aliases

if [ "`uname`" = "Darwin" ]; then
    alias ls='ls -Gp'
    which wget >/dev/null 2>&1 || alias wget='curl -O'
    alias pp='ps -eh -o user,pid,ppid,%cpu,%mem,command'
else
    alias ls='ls --color=auto -p'
    alias pp='ps -eH --headers -o user,pid,%cpu,%mem,command'
fi

# ls
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -lha'

# fasd stuff
alias v='f -t -e vim -b viminfo'
alias m='f -t -e mvim -b viminfo'
_fasd_bash_hook_cmd_complete v m


# screen
alias screen='screen -U'
alias sr='screen -r'

# working dir
alias cpwd="pwd | pbcopy"

# history search
alias hgrep='history|grep '
alias .p='. "${HOME}/.bashrc"'
alias .a='. "${HOME}/.bash_aliases"'
alias .f='. "${HOME}/.bash_defs"'

e () { "${EDITOR}" "$@"; }
# idea: this can be expanded into a dotfile-editing wrapper tool
# with fuzzy-matching
# also: my dotfiles setup stuff could also be generalized.
alias ev='e "${HOME}/.vimrc"'
alias ep='e "${HOME}/.bashrc"'
alias ea='e "${HOME}/.bash_aliases"'
alias ef='e "${HOME}/.bash_defs"'
alias eg='e "${HOME}/.gitconfig"'
alias eh='e "${HOME}/.hgrc"'

# mud habits
alias grr='echo Grrrrr.'
alias yawn='echo You must be tired.'
alias yay='echo Yayyyy!'
alias fuck='echo FUCK.'
alias sigh='echo You sigh.'
alias hmm='echo Hmmm.'
alias lol='echo Hahaha.'
alias haha='echo Hahaha.'
alias no='echo NO.'
