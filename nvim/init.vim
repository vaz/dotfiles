" V's init.nvim 2016+

" settings {{{
  " - basic sanity {{{
  set hid ve=onemore,block bs=2 mouse=a cb& cb+=unnamed sb spr ar " edit sanity
  set ts=8 sts=2 sw=2 ai si et sta " indent sanity
  " }}}
  " - UI {{{
  set shm& shm+=aI ls=2 sc so=6 siso=6 ru dy=lastline,uhex nu eb vb swb=useopen
  set ttimeout ttimeoutlen=100 updatetime=250
  set cpt& cpt+=i completeopt=menuone,longest,preview
  set wildmenu wildmode=longest,list
  set wig& wig+=*.orig,*.rej,*~,#*#,.*.s[a-w][a-z],.DS_Store,._*,.Trash
  set wig+=*.py[co],*.o,*.so,*.so.*,*.dll,*.a,*.dylib,*.exe,*.bin,*.out
  set diffopt& diffopt+=vertical
  set incsearch ignorecase smartcase
  set foldenable foldlevelstart=999
  sil! set lcs=tab:⇥\ ,trail:␣,extends:…,precedes:…,nbsp:·, list "eol:¬
  set termguicolors cursorline
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 " Change cursor shape in insert mode
  " }}}
  " - text formatting / wrapping {{{
  set tildeop
  " textwidth is normally annoying, but with fo-=t it will only do comments.
  " default fo is tcqj
  sil! set tw=78 fo& fo-=t
  let &sbr='↪ '
  set nolbr bri briopt=shift:0 cpo+=n
  aug vimrc_formatting
    au!
    " Don't auto-insert comment leaders when using o/O in normal mode
    au FileType * sil! setl fo-=o briopt=shift:0
    au FileType text,markdown,textile sil! setl lbr fo-=c briopt=shift:0,sbr tw=0
  aug end
  " }}}
  " -- history {{{
  set history=1000 viminfo=!,'20,<50,s10,h
  set nobackup writebackup undofile sessionoptions& sessionoptions-=options
  " }}}
  " - shell/terminal {{{
  " because WHAT WOULD HAPPEN??? (no really I'm not sure)
  if &shell =~# 'fish$' | set shell=/bin/bash | endif
  let g:terminal_scrollback_buffer_size = 10000
  let g:terminal_shell = 'fish'
  call termhelpers#updateansi()
  call termhelpers#autoinsertmode()
  " }}}
" }}}
" mappings {{{
  " most very plugin-specific mappings appear where the plugin is declared

  let mapleader = " "
  let maplocalleader = "  "

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

    nno <silent> q <c-w>
    nno <silent> Q <c-w>p

    nno <silent> <tab> :bn<cr>
    nno <silent> <s-tab> :bp<cr>

    " change windows with alt-hjkl (incl terminal)
    tnore <a-h> <c-\><c-n><c-w>h
    tnore <a-j> <c-\><c-n><c-w>j
    tnore <a-k> <c-\><c-n><c-w>k
    tnore <a-l> <c-\><c-n><c-w>l
    nnore <a-j> <c-w>j
    nnore <a-h> <c-w>h
    nnore <a-k> <c-w>k
    nnore <a-l> <c-w>l
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
  " }}}
  " - insert mode mappings {{{
    " better mapping for indent/dedent {{{
      " frees up ^t ^d
      inoremap <c-t> <noop>
      inoremap <c-d> <noop>
      inoremap <m-.> <c-t>
      inoremap <m-,> <c-d>
    " }}}
    inoremap <C-X>^ <C-R>=substitute(&commentstring,' \=%s\>'," -*- ".&ft." -*- vim:set ft=".&ft." ".(&et?"et":"noet")." sw=".&sw." sts=".&sts.':','')<CR>
  " }}}
  " - abbrevs {{{
    iabbrev ...~ …
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
    no _  g;zx
    no +  g,zx
    no -  <c-o>zx
    no =  <c-i>zx

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
  " - edit/source this / init file {{{
    nno <leader>ev :e $MYVIMRC<cr>
    nno <leader>ef :ef ~/.config/fish/config.fish<cr>
    nno <leader>eg :eg ~/.gitconfig<cr>
    nno <leader>ss :so %<cr>
    nno <leader>sv :so $MYVIMRC<cr>
    nno <leader>sp :PlugInstall<cr>
    nno <leader>sf :so ~/.config/fish/config.fish<cr>
    nno <leader>eg :sg ~/.gitconfig<cr>
  " }}}
  " - terminal mappings {{{
    nno <leader>to :<c-u>exe 'e term://' . g:terminal_shell<cr>i
    nno <leader>ts :<c-u>exe 'sp term://' . g:terminal_shell<cr>i
    nno <leader>tv :<c-u>exe 'vs term://' . g:terminal_shell<cr>i
    nmap <leader>t<leader> <leader>tv
  " }}}
" }}}
" plugins {{{
  syntax on
  filetype off
  " TODO: just use pathogen
  call plug#begin('~/.config/nvim/plugged')
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-unimpaired' " {{{
  " }}}
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-git'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-scriptease'
  Plug 'qpkorr/vim-bufkill'
  Plug 'chrisbra/Recover.vim'
  Plug '~/.config/nvim/vaz/altbuf.vim'
  Plug '~/.config/nvim/vaz/autosource.vim'
  Plug '~/.config/nvim/vaz/addplug.vim' " {{{
    " hi AddPluginSign guifg=#d7ff87 guibg=#1c1c1c gui=bold
    " hi AddPluginLine cterm=bold guifg=#d7ff87 guibg=#223036 gui=bold
    nno <silent> <leader>ep :AddPlug<cr>
  " }}}
  Plug '~/.config/nvim/vaz/js-cdn.vim'
  Plug 'editorconfig/editorconfig-vim' " {{{
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']
  " }}}
  Plug 'kergoth/vim-hilinks' " {{{
    nore <silent> <leader>hi :HLTX!<cr>
  " }}}
  Plug 'justinmk/vim-sneak' " {{{
    let g:sneak#s_next = 1
    map gs <Plug>(SneakStreak)
    map gS <Plug>(SneakStreakBackward)
  " }}}
  Plug 'tommcdo/vim-lion'
  Plug 'mattn/emmet-vim' " <c-y>, {{{
    " TODO: no n/v mode C-y mappings plz
  " }}}
  Plug 'terryma/vim-multiple-cursors' " {{{
    " default mapping: ^N XXX problematic
    let g:multi_cursor_exit_from_visual_mode = 0 " esc to Normal, then esc out
    let g:multi_cursor_exit_from_insert_mode = 0 " same
  " }}}
  " airline {{{
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    set noshowmode
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
    let g:airline_symbols.readonly = 'ᴿᴼ'
    " let g:airline_symbols.linenr = ''
    let g:airline_symbols.linenr = '㏑'
    let g:airline_symbols.maxlinenr = '☰'
    let g:airline_symbols.crypt = ''
    let g:airline_symbols.paste = 'ᴾ'
    let g:airline_symbols.notexists = '∄'
    let g:airline_symbols.whitespace = '⎵'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ''
    let g:airline#extensions#tabline#left_alt_sep = ' '
    let g:airline#extensions#tabline#buffers_label = 'buf'
    let g:airline#extensions#tabline#tabs_label = 'tab'
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#buffer_nr_format = '%s› '
    let g:airline_theme = 'term'
     " i wanna use ∴∵ ∴∵ ∴∵
  " }}}
  " node-host {{{
    fun! BuildNodeHost(info)
      if a:info.status != 'unchanged' || a:info.force
        !npm install
        UpdateRemotePlugins
      endif
    endfun
    Plug 'neovim/node-host', { 'do': function('BuildNodeHost') }
  " }}}
  Plug 'Shougo/neco-vim', { 'do': 'UpdateRemotePlugins' }
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
      nmap <buffer> <esc> <plug>(unite_exit)
    endfunction
    if executable('ack')
      let g:unite_source_grep_command = 'ack'
      let g:unite_source_grep_default_opts = '-i --no-heading --no-color -k -H'
      let g:unite_source_grep_recursive_opt = ''
    endif
    let g:unite_source_history_yank_enable = 1
    aug vimrc_unite
      au!
      autocmd! FileType unite call s:unite_settings()
      autocmd! VimEnter * call s:on_unite_source()
    aug end
    nnoremap [-unite] <nop>
    nmap <leader>u [-unite]
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
  Plug 'airblade/vim-gitgutter' " {{{
  " }}}
  Plug 'sheerun/vim-polyglot' " {{{
    " git filetypes (from tpope/vim-git) {{{
      " see https://github.com/tpope/vim-git

      " in git rebase -i, cycle through choices (pick, squash, etc)
      nno <buffer> <silent> S :Cycle<cr>
    " }}}
  " }}}
  " js_context_colors {{{
    fun! BuildVimJSCC(info)
      if a:info.status != 'unchanged' || a:info.force
        !npm install --update && (cd rplugin/node; npm install --update)
        UpdateRemotePlugins
      endif
    endfun
    Plug 'bigfish/vim-js-context-coloring', { 'branch': 'neovim', 'do': function('BuildVimJSCC') }
      let g:js_context_colors_enabled = 0
      let g:js_context_colors_usemaps = 0
      " let g:js_context_colors_highlight_function_names = 1
      let g:js_context_colors_jsx = 1
      au FileType javascript :noremap <buffer> <localleader>c :<c-u>JSContextColorToggle<cr>
  " }}}
  " TODO: https://github.com/ap/vim-css-color
  Plug 'tpope/vim-markdown' " {{{
    " XXX doesn't work?
    let g:markdown_fenced_languages = ['html', 'rb=ruby', 'js=javascript', 'clj=clojure']
  " }}}
  Plug 'vito-c/jq.vim'
  " clojure plugins {{{
    Plug 'tpope/vim-fireplace'
    Plug 'tpope/vim-salve' " {{{
      let g:salve_auto_start_repl = 0
    " }}}
    Plug 'guns/vim-sexp'
    Plug 'tpope/vim-sexp-mappings-for-regular-people'
  " }}}
  " colours {{{
    Plug '~/.config/nvim/vaz/vcolours.vim'
    Plug '~/.config/nvim/vaz/cyclr.vim'
    aug Colours
      au!

    " colour schemes {{{
      Plug '29decibel/codeschool-vim-theme'
      Plug 'djjcast/mirodark'
      Plug 'jonathanfilip/vim-lucius'
      Plug 'sonjapeterson/1989.vim' " {{{
        " TODO: move this, or make it part of cyclr with funcref
        fun! Patch1989() abort
          " from 'highlight'
          hi SpecialKey guibg=#303030 guifg=#b7d7ff
          hi EndOfBuffer ctermbg=NONE guibg=NONE guifg=#1c1c1c
          hi TermCursor guifg=#99ffa8 guibg=NONE gui=reverse
          hi TermCursorNC guifg=#afafaf guibg=NONE gui=reverse
          hi NonText guibg=#303030 guifg=#87afaf
          hi Directory guifg=#afdfff
          hi! link ErrorMsg Error
          hi Search guifg=#d7ff87 guibg=#1c1c1c gui=none
          hi IncSearch guifg=#d7ffaf guibg=#080808 gui=underline,bold
          hi MoreMsg guifg=#afffd7 guibg=NONE gui=italic
          hi ModeMsg guifg=#ffffff gui=bold
          hi LineNr guibg=#303030 guifg=#878787
          hi CursorLineNr guibg=#303030 guifg=#afcfcf gui=NONE
          hi! link Question MoreMsg
          hi StatusLine guibg=#1c1c1c guifg=#ffffff gui=NONE
          hi StatusLineNC guibg=#272727 guifg=#afafaf gui=NONE
          hi Title guifg=#afdfff guibg=NONE gui=NONE
          hi VertSplit guibg=#242424 guifg=#001224 gui=italic
          hi Visual guibg=black guifg=#afffdf gui=none
          hi WarningMsg gui=italic guifg=#ffdfaf guibg=#271c27
          hi! link WildMenu Visual
          hi Folded guibg=#1c1c1c guifg=#57575f gui=italic
          hi FoldColumn guibg=#272727 gui=NONE guifg=#57665f

          hi DiffAdd gui=NONE guifg=#e0e0e0 guibg=#00875f
          hi DiffChange guibg=#305787
          hi DiffText guibg=#0087af guifg=#ffffff gui=bold
          hi DiffDelete guibg=#a73057 guifg=#e0e0e0

          hi SignColumn guibg=#303030 guifg=#57665f

          hi PMenu guibg=#4c57cc guifg=#ffffff
          hi PMenuSel guibg=#5787ff guifg=#ffffff gui=bold
          hi PMenuSbar guibg=grey
          hi PMenuThumb guibg=white

          " from elsewhere
          hi CursorLine guibg=#303030
          hi CursorColumn guibg=#303030
          hi Error guifg=#ffafdf guibg=#271c27 gui=italic

          hi Comment cterm=italic gui=italic
          hi Todo guifg=#dfffaf guibg=none gui=underline,bold
          hi MatchParen guifg=#dfffaf gui=bold,underline guibg=#001230
        endfun
        au Colours ColorScheme 1989 :call Patch1989()
      " }}}
      " TODO: support funcrefs/numbered-function
      let g:cyclr#defs = {
            \ 'lucius': 'set bg=dark | colors lucius | exe "LuciusDark"',
            \ 'lucius-hi': 'set bg=dark | colors lucius | exe "LuciusDarkHighContrast"',
            \ '1989':   'set bg=dark | colors 1989 | call cyclr#clearbg()',
            \ 'galaxy': 'colors galaxy',
            \ }

      nmap <leader>C <Plug>cyclrNext
      " TODO: option
      " au VimEnter,Colorscheme * :call cyclr#clearbg()
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
  Plug 'slim-template/vim-slim'
  Plug 'scrooloose/nerdtree' " {{{
   Plug 'Xuyuanp/nerdtree-git-plugin'
    let g:NERDTreeMinimalUI = 1
    nno <silent> qt :NERDTreeToggle<cr>
    aug vimrc_nerdtree
      au!
      " How can I open NERDTree automatically when vim starts up on opening a directory?
      au StdinReadPre * let s:std_in=1
      au VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
      " How can I close vim if the only window left open is a NERDTree?
      au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    aug end
  " }}}
  "__plugintail__

  " TODO: neomake instead of syntastic
  call plug#end()
  filetype plugin indent on
" }}}
if has('vim_starting') " set initial colours {{{
  let s:coloured = 1
  set bg=dark
  call cyclr#activate('1989')
endif " }}}
aug vimrc " autocommands {{{
  " when editing a file, always jump to the last known cursor position.
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
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
  au BufWinEnter * normal! zx

augroup end " }}}

" -*- vim -*- vim:set ft=vim et sw=2 sts=2 fdls=1 fdm=marker fdl=999:
