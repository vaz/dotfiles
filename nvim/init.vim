" V's init.nvim 2016+
"
" settings {{{

  set hid ve=onemore,block bs=2 mouse=a cb+=unnamed sb spr ar " editor sanity
  set ts=8 sts=2 sw=2 ai si et sta " indent sanity
  set shortmess=atToOI ls=2 showcmd so=1 siso=5 ru dy=lastline nu noeb vb
  set history=1000 viminfo=!,'20,h,<50,s10
  set ttimeout ttimeoutlen=100
  set complete-=i completeopt=menuone,longest,preview
  set wildmenu wildmode=longest,list
  set wildignore+=*.orig,*.rej,*~,#*#,.*.s[a-w][a-z],.DS_Store,._*,.Trash
  set wildignore+=*.py[co],*.o,*.so,*.so.*,*.dll,*.a,*.dylib,*.exe,*.bin,*.out
  set switchbuf=useopen
  set incsearch ignorecase smartcase
  set diffopt+=vertical sessionoptions-=options
  set foldenable foldmethod=syntax foldlevel=999
  sil! set formatoptions+=j
  sil! set lcs=tab:→\ ,trail:␣,extends:…,precedes:…,nbsp:·, list sbr=↪  "eol:¬
  set termguicolors
  set nobackup writebackup undofile

  " because WHAT WOULD HAPPEN???
  if &shell =~# 'fish$' | set shell=/bin/bash | endif

  " Change cursor shape in insert mode
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" }}}
" mappings {{{
  " most very plugin-specific mappings appear where the plugin is declared

  " - buffer/window mappings {{{

    nno <silent> `     :call altbuf#flip_if_listed()<cr>

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

    nno <silent> Q <c-w>p

    nno <silent> <tab> :bn<cr>
    nno <silent> <s-tab> :bp<cr>

  " }}}
  " - movement/viewport {{{

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

  " }}}
  " - editing {{{

    " start new change for insert mode ^U
    ino <C-U> <C-G>u<C-U>

    " make R in visual mode do what I would expect it to
    vno R r R

    " ^L for nohl/diffup
    nno <silent> <c-l> :nohl<bar>diffup!<cr>
  " }}}
  " - insert mode mappings {{{
    inoremap <C-X>^ <C-R>=substitute(&commentstring,' \=%s\>'," -*- ".&ft." -*- vim:set ft=".&ft." ".(&et?"et":"noet")." sw=".&sw." sts=".&sts.':','')<CR>
  " }}}
  " - text objects {{{

    " r for [ text obj
    onoremap ir i[
    onoremap ar a[
    vnoremap ir i[
    vnoremap ar a[

  " }}}
  " - marks, registers, changes, jumps {{{

    nno Y y$

    " ` is always better than ', free up `
    nno  ' `
    nno g' '

    " navigate changelist with _ and +, jumplist with - and =
    no g= =
    no _  g;
    no +  g,
    no -  <c-o>
    no =  <c-i>

    " paste with blackhole register to preserve current register contents
    " XXX:
    " nno <silent> 0p "_p
    " nno <silent> 0P "_P

    " select last put text
    nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]'

  " }}}
  " - Apple HIG style movements {{{

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

  " }}}
  " - source this / source init file {{{
    nno <leader>ss :so %<cr>
    nno <leader>sc :so ~/.config/nvim/init.vim<cr>
  " }}}
" }}}
" plugins {{{
  syntax on
  filetype off
  call plug#begin('~/.config/nvim/plugged')
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-unimpaired' " {{{
    " - dragging lines (with meta-j/k) {{{

      nmap <silent>        <m-j> <Plug>unimpairedMoveDown
      nmap <silent>        <m-k> <Plug>unimpairedMoveUp
      vmap <silent> <expr> <m-j> '<Plug>unimpairedMoveSelectionDown'.'gv'
      vmap <silent> <expr> <m-k> '<Plug>unimpairedMoveSelectionUp'.'gv'

    " }}}
  " }}}
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-git'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-obsession'
  Plug 'chrisbra/Recover.vim'
  Plug 'editorconfig/editorconfig-vim' " {{{
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']
  " }}}
  Plug 'tpope/vim-scriptease', { 'for': 'vim' }
  Plug 'qpkorr/vim-bufkill'
  Plug 'justinmk/vim-sneak' " {{{
    let g:sneak#s_next = 1
    map gs <Plug>(SneakStreak)
    map gS <Plug>(SneakStreakBackward)
    map f <Plug>Sneak_f
    map F <Plug>Sneak_F
    map t <Plug>Sneak_t
    map T <Plug>Sneak_T
  " }}}
  Plug 'tommcdo/vim-lion'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'vim-airline/vim-airline' "{{{
    let g:airline_mode_map = {
        \ '__' : '-',
        \ 'n'  : 'N',
        \ 'i'  : 'I',
        \ 'R'  : 'R',
        \ 'c'  : 'C',
        \ 'v'  : 'V',
        \ 'V'  : 'V',
        \ '' : 'V',
        \ 's'  : 'S',
        \ 'S'  : 'S',
        \ '' : 'S',
        \ }
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif
    " unicode symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    " let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
    let g:airline_symbols.maxlinenr = '☰'
    let g:airline_symbols.crypt = '🔒'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.notexists = '∄'
    let g:airline_symbols.whitespace = 'Ξ'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ''
    let g:airline#extensions#tabline#left_alt_sep = ''
  " }}}
  Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' } " {{{
    let g:deoplete#enable_at_startup = 1
    " https://github.com/clojure-vim/async-clj-omni
    " https://github.com/carlitux/deoplete-ternjs
  " }}}
  Plug 'Shougo/neoyank.vim'
  Plug 'Shougo/neomru.vim'
  Plug 'Shougo/unite.vim' " {{{
    function! s:on_unite_source()
      call unite#filters#matcher_default#use(['matcher_fuzzy'])
      call unite#filters#sorter_default#use(['sorter_rank'])
      call unite#custom#profile('default', 'context', { 'start_insert': 1, 'smartcase': 1 })
    endfunction
   function! s:unite_settings()
      nmap <buffer> Q <plug>(unite_exit)
      nmap <buffer> <esc> <plug>(unite_exit)
    endfunction
    if executable('ack')
      let g:unite_source_grep_command = 'ack'
      let g:unite_source_grep_default_opts = '-i --no-heading --no-color -k -H'
      let g:unite_source_grep_recursive_opt = ''
    endif
    let g:unite_source_history_yank_enable = 1
    autocmd! FileType unite call s:unite_settings()
    autocmd! VimEnter * call s:on_unite_source()
    nnoremap [-unite] <nop>
    nmap <space> [-unite]
    nnoremap <silent> [-unite]<space>  :Unite -buffer-name=files     -no-split -auto-preview -vertical-preview buffer file_rec<cr>
    nnoremap <silent> [-unite]F        :Unite -buffer-name=files     -no-split -auto-preview -auto-highlight -vertical-preview file_rec<cr>
    nnoremap <silent> [-unite]g        :Unite -buffer-name=files     -no-split -auto-preview -auto-highlight -vertical-preview file_rec/git<cr>
    nnoremap <silent> [-unite]'        :Unite -buffer-name=register  -no-start-insert -auto-resize register<cr>
    nnoremap <silent> [-unite]m        :Unite -buffer-name=mapping   -no-start-insert mapping<cr>
    nnoremap <silent> [-unite]j        :Unite -buffer-name=jumps     -no-split -auto-preview -auto-highlight -vertical-preview -no-start-insert jump<cr>
    nnoremap <silent> [-unite]c        :Unite -buffer-name=changes   -no-split -auto-preview -auto-highlight -vertical-preview -no-start-insert change<cr>
    nnoremap <silent> [-unite]C        :Unite -buffer-name=command   command<cr>
    nnoremap <silent> [-unite]f        :Unite -buffer-name=files     -no-split -auto-preview -vertical-preview file<cr>
    nnoremap <silent> [-unite]d        :Unite -buffer-name=dirs      directory<cr>
    nnoremap <silent> [-unite]p        :Unite -buffer-name=rtp       -no-split -auto-preview -vertical-preview runtimepath<cr>
    nnoremap <silent> [-unite]y        :Unite -buffer-name=yanks     -no-start-insert history/yank<cr>
    " nnoremap <silent> [-unite]/        :Unite -buffer-name=grep      -no-split -auto-preview -vertical-preview grep:.<cr>
    nnoremap <silent> [-unite]G        :Unite -buffer-name=gotoline  -auto-resize line<cr>
    nnoremap <silent> [-unite]r        :Unite -buffer-name=recent    -no-split -auto-preview -vertical-preview file_mru directory_mru<cr>
    nnoremap <silent> [-unite]<tab>    :Unite -buffer-name=buffers   -quick-match -no-start-insert -winheight=10 buffer<cr>
  " }}}
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " {{{
    nnoremap <cr> :<c-u>FZF<cr>
  " }}}
  Plug 'mhinz/vim-signify' " {{{
    let g:signify_vcs_list = ['git', 'hg']
  " }}}
  Plug 'sheerun/vim-polyglot' " {{{
    " git filetypes (from tpope/vim-git) {{{
      " see https://github.com/tpope/vim-git

      " in git rebase -i, cycle through choices (pick, squash, etc)
      nno <buffer> <silent> S :Cycle<cr>
    " }}}
  " }}}
  Plug 'tpope/vim-markdown' " {{{
    " XXX doesn't work?
    let g:markdown_fenced_languages = ['html', 'rb=ruby', 'js=javascript', 'clj=clojure']
  " }}}
  " clojure plugins {{{
    Plug 'tpope/vim-fireplace'
    Plug 'tpope/vim-salve' " {{{
      let g:salve_auto_start_repl = 0
    " }}}
    Plug 'guns/vim-sexp'
    Plug 'tpope/vim-sexp-mappings-for-regular-people'
  " }}}
  " colours {{{
    aug Colours

    " colour schemes {{{
      Plug '29decibel/codeschool-vim-theme'
      Plug 'djjcast/mirodark'
      Plug 'jonathanfilip/vim-lucius'
      Plug 'sonjapeterson/1989.vim' " {{{
        au Colours ColorScheme 1989 :hi Todo cterm=bold gui=bold ctermfg=229 ctermbg=yellow guifg=#111223 guibg=#ffffaf
      " }}}

      au VimEnter,Colorscheme * :call colours#clearbg()
    " }}}

      Plug 'kien/rainbow_parentheses.vim' " {{{
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
        let g:rbpt_max = 16
        let g:rbpt_loadcmd_toggle = 1
        au VimEnter * RainbowParenthesesToggle
        au Syntax * RainbowParenthesesLoadRound
        au Syntax * RainbowParenthesesLoadSquare
        au Syntax * RainbowParenthesesLoadBraces
      " }}}
    aug end
  " }}}
" }}}

" TODO: neomake instead of syntastic

call plug#end()

filetype plugin indent on
" }}}
" colours {{{

  let g:colours#definitions = {
        \ 'lucius': 'set bg=dark | colors lucius | exe "LuciusDark"',
        \ 'lucius-hi': 'set bg=dark | colors lucius | exe "LuciusDarkHighContrast"',
        \ '1989':   'set bg=dark | colors 1989',
        \ 'galaxy': 'colors galaxy',
        \ }

  nmap <leader>C <Plug>coloursCycle

  if !exists('s:coloured')
    let s:coloured = 1
    call colours#activate('1989')
  endif

" }}}
aug vimrc " autocommands {{{
  " when editing a file, always jump to the last known cursor position.
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " don't always center the cursor in screen when switching buffers
  au BufLeave * let b:winview = winsaveview()
  au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif

  " resize splits when window is resized
  au VimResized * :wincmd =

  au BufNewFile,BufRead * if &syntax == '' | set foldmethod=indent | endif

  au FileType make setlocal noexpandtab

  au FileType help nnoremap <silent> <buffer> <cr> <c-]>

  " always show where we are, foldwise
  au BufReadPost * normal! zv

augroup end " }}}

" -*- vim -*- vim:set ft=vim et sw=2 sts=2 fdls=1 fdm=marker fdl=999:
