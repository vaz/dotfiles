# Vaz's bash aliases

if [ "`uname`" = "Darwin" ]; then
    alias ls='ls -Gp'
    type -t wget >&- 2>&- || alias wget='curl -O'
    pcmd='ps -e -o user,pid,ppid,%cpu,%mem,command'
else
    alias ls='ls --color=auto -p --group-directories-first'
    pcmd='ps -eH -o user,pid,%cpu,%mem,command'
fi
alias pp="$pcmd"
alias pf="$pcmd | grep"

# ls
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -lha'

# fasd stuff
alias v='f -t -e vim -B viminfo'
alias m='f -t -e mvim -B viminfo'
_fasd_bash_hook_cmd_complete v m

# dash (not the shell)
alias -- '-'=dash_
alias marked='open -a marked'

# screen
alias screen='screen -U'
alias sr='screen -r'

# terminal clock
alias clock='watch --no-title --interval=1 date'

# working dir
alias cpwd="pwd | pbcopy"

# flip between directories
alias b='cd $OLDPWD'

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
alias ugh='echo UGH.'
alias wtf='echo what the fuck.'
