fun! colours#patchUI() abort
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
