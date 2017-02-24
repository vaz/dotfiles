" V's init.nvim 2016+

                                                            " ∴∵ settings {{{1

                                                      " ∴∵∴∵ basic sanity {{{2

set hid ve=onemore,block bs=2 mouse=a cb& cb+=unnamed sb spr ar   " edit sanity
set ts=8 sts=2 sw=2 ai si et sta                                " indent sanity

                                                                " ∴∵∴∵ UI {{{2

set shm& shm+=aI ls=2 sc so=6 siso=6 ru dy=lastline,uhex nonu eb vb swb=useopen
set ttimeout ttimeoutlen=100 updatetime=500
set cpt& cpt+=i completeopt=menuone,longest,preview
set wildmenu wildmode=longest,list
set wig& wig+=*.orig,*.rej,*~,#*#,.*.s[a-w][a-z],.DS_Store,._*,.Trash
set wig+=*.py[co],*.o,*.so,*.so.*,*.dll,*.a,*.dylib,*.exe,*.bin,*.out
set diffopt& diffopt+=vertical
set incsearch ignorecase smartcase
set foldenable foldlevelstart=999
sil! set lcs=tab:⇥\ ,trail:␣,extends:…,precedes:…,nbsp:·, list "eol:¬
set termguicolors cursorline
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1   " Change cursor shape in insert mode

                                        " ∴∵∴∵ text formatting / wrapping {{{2

sil! set tw=78 fo& fo-=t              " textwidth is normally annoying, but
let &sbr='↪ '                         " with fo-=t it will only do comments.
set nolbr bri briopt=shift:0 cpo+=n   " default 'fo' is tcqj
aug vimrc_formatting
  au!
  " Don't auto-insert comment leaders when using o/O in normal mode.
  au FileType * sil! setl fo-=o briopt=shift:0
  au FileType text,markdown,textile
    \ sil! setl lbr fo-=c briopt=shift:0,sbr tw=0
aug end

                                                     " ∴∵∴∵ shada/session {{{2

set history=1000 viminfo=!,'20,<50,s10,h
set nobackup writebackup undofile sessionoptions& sessionoptions-=options

                                                    " ∴∵∴∵ shell/terminal {{{2

if &shell =~# 'fish$' | set shell=/bin/bash | endif
let g:terminal_scrollback_buffer_size = 10000
let g:terminal_shell = 'fish'
call termhelpers#updateansi()
call termhelpers#autoinsertmode()
                                                                        " }}}2

                                                            " ∴∵ mappings {{{1

" (most very-plugin-specific mappings are done where the plugin is declared)

                                                            " ∴∵∴∵ leader {{{2

let mapleader = " "
let maplocalleader = "  "

nore <nowait> <leader>          <nop>
nore <nowait> <leader><leader>  <nop>
nore <nowait> <leader><esc>     <nop>

                                            " ∴∵∴∵ buffer/window mappings {{{2

nno <silent> \     :call altbuf#flip_if_listed()<cr>

nno <leader>q q
nno <leader>Q Q

nno <silent> qd :bd<cr>
nno <silent> qD :bd!<cr>
nno <silent> qw <c-w>c
nno <silent> qb :BD<cr>
nno <silent> qB :BD!<cr>
nno <silent> qu :BUNDO<cr>

nno <silent> qq <c-w>w
nno <silent> qQ <c-w>W

nno <silent> q <c-w>
nno <silent> Q <c-w>p

nno <silent> ( :bn<cr>
nno <silent> ) :bp<cr>

" change windows with alt-hjkl (incl terminal)
tnore <a-h> <c-\><c-n><c-w>h
tnore <a-j> <c-\><c-n><c-w>j
tnore <a-k> <c-\><c-n><c-w>k
tnore <a-l> <c-\><c-n><c-w>l
nnore <a-j> <c-w>j
nnore <a-h> <c-w>h
nnore <a-k> <c-w>k
nnore <a-l> <c-w>l

                                                 " ∴∵∴∵ movement/viewport {{{2

" H and L aren't as helpful as ^ and $
no H ^
no L $

" scroll viewport faster
nno <c-e> 5<c-e>
nno <c-y> 5<c-y>

" j/k more natural on wrapped lines
no   j  gj
no   k  gk
no   gj j
no   gk k
ounm j
ounm k

                                                           " ∴∵∴∵ editing {{{2

nore <silent> <f2> :set paste!<cr>

" start new change for insert mode ^U
ino <C-U> <C-G>u<C-U>

" ds<bs> delete surrounding whatever encloses the word
nno <silent> <Plug>Dsurround<bs> gew:exe 'normal ds'.getline('.')[col('.')-2]<cr>
" insert mode version, <m-bs>
imap <silent> <m-bs> <c-\><c-o>ds<bs><cr>

" insert pairs of things
imap <m-'> <c-g>s'
imap <m-"> <c-g>s"
imap <m-`> <c-g>s`
imap <m-(> <c-g>s(
imap <m-b> <c-g>sb
imap <m-[> <c-g>s[
imap <m-r> <c-g>sr
imap <m-{> <c-g>s{
imap <m-c> <c-g>sc
imap <m-<> <c-g>s<
imap <m-a> <c-g>sa

" make R in visual mode do what I would expect it to
vno R r R

" ^L for nohl/diffup
nno <silent> <c-l> :nohl<bar>match<bar>2match<bar>diffup!<cr>zx

                                              " ∴∵∴∵ insert mode mappings {{{2

" better mapping for indent/dedent (frees ^T, ^D) {{{3
inoremap <c-t> <noop>
inoremap <c-d> <noop>
inoremap <m-.> <c-t>
inoremap <m-,> <c-d>

" insert vim modeline {{{3
inoremap <C-X>^ <C-R>=substitute(&commentstring,' \=%s\>'," -*- ".&ft." -*- vim:set ft=".&ft." ".(&et?"et":"noet")." sw=".&sw." sts=".&sts.':','')<CR>

" abbrevs {{{3
iabbrev ...~ …
" }}}

                                                      " ∴∵∴∵ text objects {{{2

onoremap ir i[
onoremap ar a[
vnoremap ir i[
vnoremap ar a[

                                                      " ∴∵∴∵ highlighting {{{2


" hi! Match1 ctermfg=none ctermbg=lightblue cterm=bold gui=none guifg=none guibg=#4c57cc

" vno <leader>m1 "my:match  Match1  /\V<c-r>=substitute(escape(@m, '/\'), '\n', '\\n', 'g')<cr>/<cr>
" vno <leader>m2 "my:2match Match2  /\V<c-r>=substitute(escape(@m, '/\'), '\n', '\\_$', 'g')<cr>/<cr>
" vno <leader>m3 "my:3match Match3  /\V<c-r>=substitute(escape(@m, '/\'), '\n', '\\_$', 'g')<cr>/<cr>

" nmap <leader>m1 viW<leader>m1
" nmap <leader>m2 viW<leader>m2
" nmap <leader>m3 viW<leader>m3

                                  " ∴∵∴∵ marks, registers, changes, jumps {{{2

nno Y y$

" navigate jumplist
no ( <c-o>zx
no ) <c-i>zx

" select last put text
nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]'

                                         " ∴∵∴∵ Apple HIG style movements {{{2

" iTerm2: option/alt sends Esc+, cmd-arrow sends ctrl-arrow
" Meta/Cmd arrows: send escape seq ^[[1;3X for meta, 1;5X for ctrl, X is ABCD for UDRL

no  <c-left>    <home>
no! <c-left>    <home>
no  <c-right>   <end>
no! <c-right>   <end>
no  <c-up>      <c-home>
no  <c-down>    <c-end>
no  <m-left>    <c-left>
no! <m-left>    <c-left>
no  <m-right>   <c-right>
no! <m-right>   <c-right>
no  <m-up>      {
no! <m-up>      <c-o>{
no  <m-down>    }
no! <m-down>    <c-o>}
ino <m-bs>      <c-w>
ino <D-BS>      <esc>ld0i

                                             " ∴∵∴∵ edit/source shortcuts {{{2

nno <leader>ev :e $MYVIMRC<cr>
nno <leader>ef :e ~/.config/fish/config.fish<cr>
nno <leader>eg :e ~/.gitconfig<cr>
nno <leader>ss :so %<cr>
nno <leader>sv :so $MYVIMRC<cr>
nno <leader>sp :PlugInstall<cr>
nno <leader>sf :so ~/.config/fish/config.fish<cr>
nno <leader>sg :so ~/.gitconfig<cr>

                                                 " ∴∵∴∵ terminal mappings {{{2

nno <leader>to :<c-u>exe 'e term://' . g:terminal_shell<cr>i
nno <leader>ts :<c-u>exe 'sp term://' . g:terminal_shell<cr>i
nno <leader>tv :<c-u>exe 'vs term://' . g:terminal_shell<cr>i
nmap <leader>t<leader> <leader>tv

                                                                        " }}}2

                                                             " ∴∵ plugins {{{1

" TODO: just use pathogen
call plug#begin('~/.config/nvim/plugged')

                           " ∴∵∴∵ plugins that should just be part of vim {{{2

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'qpkorr/vim-bufkill'
Plug 'chrisbra/Recover.vim'

Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'

                                      " ∴∵∴∵ plugins about making plugins {{{2

Plug 'tpope/vim-scriptease'
Plug 'kergoth/vim-hilinks'
  nore <silent> <leader>hi :HLTX!<cr>

                                         " ∴∵∴∵ my plugins in development {{{2

Plug '~/.config/nvim/vaz/altbuf.vim'
Plug '~/.config/nvim/vaz/autosource.vim'
Plug '~/.config/nvim/vaz/js-cdn.vim'

Plug '~/.config/nvim/vaz/addplug.vim'
  " hi AddPluginSign guifg=#d7ff87 guibg=#1c1c1c gui=bold
  " hi AddPluginLine cterm=bold guifg=#d7ff87 guibg=#223036 gui=bold
  nno <silent> <leader>ep :AddPlug<cr>

Plug '~/.config/nvim/vaz/filling.vim'
  " filling (underlines, horizontal rules)
  nmap <leader>FF <plug>fillingHR
  nmap <leader>FU <plug>fillingUL

Plug '~/.config/nvim/vaz/nerdtree-git-menu.vim'

                                                    " ∴∵∴∵ motion plugins {{{2

Plug 'justinmk/vim-sneak'
  " TODO: S?
  " TODO: vs easymotion? seek?
  let g:sneak#s_next = 1
  map gs <Plug>(SneakStreak)
  map gS <Plug>(SneakStreakBackward)

                           " ∴∵∴∵ plugins about editing text specifically {{{2

Plug 'editorconfig/editorconfig-vim'
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'tommcdo/vim-lion'
Plug 'vim-scripts/AlignFromCursor'

Plug 'mattn/emmet-vim'
  " <c-y>, etc
  " TODO: no n/v mode C-y mappings plz

Plug 'terryma/vim-multiple-cursors'
  " default mapping: ^N XXX problematic
  let g:multi_cursor_exit_from_visual_mode = 0 " esc to Normal, then esc out
  let g:multi_cursor_exit_from_insert_mode = 0 " same

                                           " ∴∵∴∵ statusline: vim-airline {{{2

Plug 'vim-airline/vim-airline'
  set noshowmode

                                                " ∴∵∴∵∴∵ airline_mode_map {{{3
  let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : '🄽 ',
      \ 'i'  : '🄸 ',
      \ 'R'  : '🅁 ',
      \ 'c'  : '🄲 ',
      \ 'v'  : '🅅 ',
      \ 'V'  : '🆅 ',
      \ '' : '🅥 ',
      \ 's'  : '🅂 ',
      \ 'S'  : '🆂 ',
      \ '' : '🅢 ',
      \ 't'  : '🅃 '
      \ }

                                                 " ∴∵∴∵∴∵ airline_symbols {{{3

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  " let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = 'ᴿᴼ'
  " let g:airline_symbols.linenr = ''
  let g:airline_symbols.linenr = '㏑'
  let g:airline_symbols.maxlinenr = '☰'
  let g:airline_symbols.crypt = ''
  let g:airline_symbols.paste = 'ᴾ'
  let g:airline_symbols.notexists = '∄'
  let g:airline_symbols.whitespace = '⎵'

                                      " ∴∵∴∵∴∵ airline#extensions#tabline {{{3

  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ' '
  let g:airline#extensions#tabline#buffers_label = 'buf'
  let g:airline#extensions#tabline#tabs_label = 'tab'
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#tabline#buffer_nr_format = '%s› '

                                                   " ∴∵∴∵∴∵ airline_theme {{{3

Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme = 'vterm'

                                              " ∴∵∴∵ neovim rplugin hosts {{{2

Plug 'neovim/node-host', { 'do': function('build#node_host') }

                                                        " ∴∵∴∵ completion {{{2

Plug 'Shougo/neco-vim', { 'do': 'UpdateRemotePlugins' }
Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
  " TODO more completion:
  " https://github.com/clojure-vim/async-clj-omni
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  " js completion
  " requires neovim python-client
  "     pip3 install neovim
  " Add extra filetypes
  let g:tern#filetypes = ['jsx', 'javascript.jsx']
" Plug 'eaglemt/neco-ghc'

Plug 'ervandew/supertab'

                                                             " ∴∵∴∵ unite {{{2

                                                   " ∴∵∴∵∴∵ unite sources {{{3

Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neomru.vim'
Plug 'ujihisa/unite-colorscheme'

                                                       " ∴∵∴∵∴∵ unite.vim {{{3

Plug 'Shougo/unite.vim'

  function! s:on_unite_source()
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#custom#profile('default', 'context', { 'split': 0, 'wipe': 1, 'smartcase': 1, 'vertical-preview': 1 })
  endfunction
  function! s:unite_settings()
    nmap <buffer> <esc> <plug>(unite_exit)
    nmap <buffer> qb <plug>(unite_exit)
    nmap <buffer> qd <plug>(unite_exit)
    nmap <buffer> qc <plug>(unite_exit)
    nnoremap <silent><buffer><expr> s unite#do_action('split')
    nnoremap <silent><buffer><expr> v unite#do_action('vsplit')
  endfunction
  if executable('ag')
    let g:unite_source_rec_async_command = ['ag', '--filename', '--numbers', '--noheading', '--follow', '--hidden', '--ignore=.git', '--nocolor', '--hidden', '-g']
    let g:unite_source_rec_async_command = ['ag', '--nogroup', '--follow', '--hidden', '--ignore=.git', '--nocolor', '-g', '']
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--filename --numbers --noheading --follow --hidden --ignore=.git --nocolor --hidden'
    let g:unite_source_grep_recursive_opt = ''
  endif
  let g:unite_source_history_yank_enable = 1
  " can be myalias: { source: sourcename, args: whatever, description: ... }
  let g:unite_source_alias_aliases = {
    \ 'b': 'buffer',
    \ 'fr': 'file_rec/neovim',
    \ 'fp': 'file_rec/neovim:!',
    \ 'fh': 'file_rec/neovim:?',
    \ 'rtp': 'runtimepath',
    \ 'y': 'history/yank',
    \ 'reg': 'register',
    \ 'mru': 'file_mru',
    \ 'bm': 'bookmark'
  \ }
  aug vimrc_unite
    au!
    autocmd! FileType unite call s:unite_settings()
    autocmd! VimEnter * call s:on_unite_source()
  aug end

                                                  " ∴∵∴∵∴∵ unite mappings {{{3

  nnoremap [-unite] <nop>
  nmap <leader>u [-unite]

  " Unite buffer
  " -default-action=
  nnoremap <silent> [-unite]u        :Unite -buffer-name=unite<cr>
  nnoremap <silent> [-unite]o        :Unite -buffer-name=files     buffer bookmark file<cr>
  nnoremap <silent> [-unite]b        :Unite -buffer-name=buffers   buffer<cr>
  nnoremap <silent> [-unite]f        :Unite -buffer-name=files     -start-insert file_rec/neovim:!<cr>
  nnoremap <silent> [-unite]F        :Unite -buffer-name=files     -start-insert file_rec/neovim:?<cr>
  nnoremap <silent> [-unite]p        :Unite -buffer-name=rtp       -start-insert -default-action=narrow runtimepath<cr>
  nnoremap <silent> [-unite]R        :Unite -buffer-name=recent    -start-insert file_mru<cr>

  nnoremap <silent> [-unite]j        :Unite -buffer-name=jumps     jump<cr>
  nnoremap <silent> [-unite]c        :Unite -buffer-name=changes   change<cr>
  nnoremap <silent> [-unite]g        :Unite -buffer-name=goto      line<cr>

  nnoremap <silent> [-unite]r        :Unite -buffer-name=register  register<cr>
  nnoremap <silent> [-unite]y        :Unite -buffer-name=yanks     history/yank<cr>


                                                      " ∴∵∴∵ fuzzy-finder {{{2

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  nnoremap <leader>f :<c-u>FZF<cr>

                                                  " ∴∵∴∵ filetype plugins {{{2

" TODO: https://github.com/ap/vim-css-color

Plug 'sheerun/vim-polyglot'
Plug 'slim-template/vim-slim'
Plug 'vito-c/jq.vim'
Plug 'tpope/vim-markdown'
  " XXX doesn't work?
  let g:markdown_fenced_languages = ['html', 'rb=ruby', 'js=javascript', 'clj=clojure']

                                                              " ∴∵∴∵∴∵ JS {{{3

Plug 'ternjs/tern_for_vim'
Plug 'bigfish/vim-js-context-coloring', { 'branch': 'neovim', 'do': function('build#jscc') }
    let g:js_context_colors_enabled = 0
    let g:js_context_colors_usemaps = 0
    " let g:js_context_colors_highlight_function_names = 1
    let g:js_context_colors_jsx = 1
    au FileType javascript :noremap <buffer> <localleader>c :<c-u>JSContextColorToggle<cr>

                                                    " ∴∵∴∵∴∵ clojure REPL {{{3
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-salve'

" let g:salve_auto_start_repl = 1
function! FixedPiggie() abort
  echo "Connecting to REPL..."
  sil! Eval 1
  echo "Connected. Piggiebacking browser REPL..."
  Piggieback (adzerk.boot-cljs-repl/repl-env)
  echo "Connected to browser REPL."
endfun
command! Piggie call FixedPiggie()

                                           " ∴∵∴∵∴∵ editing s-expressions {{{3

Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

                                                               " ∴∵∴∵ git {{{2


" polyglot provides vim-git (https://github.com/tpope/vim-git)
  " in git rebase -i, cycle through choices (pick, squash, etc)
  aug vimrc_git
    au!
    au FileType gitrebase nno <buffer> <silent> S :Cycle<cr>
    au FileType gitcommit nno <buffer> <silent> qq :<c-u>bd<cr>
  aug end

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'
  nmap ]c <Plug>GitGutterNextHunkzx
  nmap [c <Plug>GitGutterPrevHunkzx
  " TODO: I wanna make an extension for this called gutter-hunks just because
  " of the name. I mean come on.

                                                           " ∴∵∴∵ colours {{{2

exe 'aug Colours' | exe 'au!' | exe 'aug end'

                                                  " ∴∵∴∵∴∵ colour schemes {{{3

Plug '~/.config/nvim/vaz/vcolours.vim'
Plug '29decibel/codeschool-vim-theme'
Plug 'djjcast/mirodark'
Plug 'jonathanfilip/vim-lucius'
Plug 'sonjapeterson/1989.vim'
  au Colours ColorScheme 1989 :call colours#patchUI()
  au Colours ColorScheme 1989 :hi Normal guibg=#242424

                                                     " ∴∵∴∵∴∵ cyclr setup {{{3

Plug '~/.config/nvim/vaz/cyclr.vim'
  " TODO: support funcrefs

  " colour defs {{{
  let g:cyclr#defs = {
  \ 'lucius': 'set bg=dark | colors lucius | exe "LuciusDark"',
  \ 'lucius-hi': 'set bg=dark | colors lucius | exe "LuciusDarkHighContrast"',
  \ '1989':   'set bg=dark | colors 1989',
  \ 'galaxy': 'colors galaxy',
  \ }
  " }}}

  nmap <leader>C <Plug>cyclrNext

  " TODO: option
  " au VimEnter,Colorscheme * :call cyclr#clearbg()

                                                  " ∴∵∴∵∴∵ rainbow parens {{{3

Plug 'kien/rainbow_parentheses.vim'
  let g:rbpt_max = 16
  let g:rbpt_loadcmd_toggle = 1

  " rbpg_colorpairs {{{
  let g:rbpt_colorpairs = [
  \ ['brown',       'RoyalBlue3'],
  \ ['Darkblue',    'SeaGreen3'],
  \ ['darkgray',    'DarkOrchid3'],
  \ ['darkgreen',   'firebrick3'],
  \ ['darkcyan',    'RoyalBlue3'],
  \ ['darkred',     'SeaGreen3'],
  \ ['darkmagenta', 'DarkOrchid3'],
  \ ['brown',       'firebrick3'],
  \ ['gray',        'RoyalBlue3'],
  \ ['black',       'SeaGreen3'],
  \ ['darkmagenta', 'DarkOrchid3'],
  \ ['Darkblue',    'firebrick3'],
  \ ['darkgreen',   'RoyalBlue3'],
  \ ['darkcyan',    'SeaGreen3'],
  \ ['darkred',     'DarkOrchid3'],
  \ ['red',         'firebrick3'],
  \ ]
  " }}}

  aug vimrc_rbpt
    au!
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
  aug end

                                                          " ∴∵∴∵ NERDTree {{{2

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeShowHidden = 1
  nno <silent> qt :NERDTreeToggle<cr>
  aug vimrc_nerdtree
    au!
    " How can I open NERDTree automatically when vim starts up on opening a directory?
    au StdinReadPre * let s:std_in=1
    au VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd h | endif
    " How can I close vim if the only window left open is a NERDTree?
    au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  aug end

                                                        " ∴∵∴∵ trying out {{{2
Plug 'junegunn/limelight.vim'
  let g:limelight_conceal_ctermfg = '233'
  let g:limelight_conceal_guifg = '#242424'

"__plugintail__

" ∴∵∴∵ to try {{{2

" tpope/vim-pathogen - https://github.com/tpope/vim-pathogen
"   - yup I bet it's better because I can understand it
" xolox/easy-tags - https://github.com/xolox/vim-easytags
"   - automatically generate ctags
" tpope/vim-rsi - https://github.com/tpope/vim-rsi
"   - readline-style (or emacs-style) key bindings (i/c mode)
" romainl/vim-cool
"  - hlsearch stuff
"
                                                               " ∴∵∴∵ end {{{2

call plug#end()

                                                  " ∴∵ initialize colours {{{1

if has('vim_starting')
  let s:coloured = 1
  set bg=dark
  call cyclr#activate('1989')
endif

                                                            " ∴∵ autocmds {{{1

aug vimrc
  au!
  " when editing a file, always jump to the last known cursor position.
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " don't always center the cursor in screen when switching buffers
  au BufWinLeave * let b:winview = winsaveview()
  au BufWinEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif

  " resize splits when window is resized
  " au VimResized * :wincmd =

  au BufNewFile,BufRead * if &syntax == '' | set foldmethod=indent | endif

  au FileType make setl noet

  au FileType help nnore <silent> <buffer> <cr> <c-]>

  " always show where we are, foldwise
  au BufWinEnter * normal! zx

  au BufWinEnter,WinEnter * setl cursorline<
  au WinLeave * setl nocursorline

augroup end


                                                             " ∴∵ testing {{{1

nmap ]] :bnext<cr>
nmap [[ :bprev<cr>


                                                                 " ∴∵ end {{{1
" -*- vim -*- vim:set ft=vim et sw=2 sts=2 fdl=999 fdm=marker tw=78:
