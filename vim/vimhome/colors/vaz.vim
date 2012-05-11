" vaz vim color file
" for 256 colour terminals

set background=dark

hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "vaz"

hi Normal       cterm=NONE  ctermfg=229 ctermbg=NONE  " #ffffaf #00005f
hi NonText                  ctermfg=234                " dark grey

hi Cursor       cterm=NONE  ctermfg=16  ctermbg=229   " #000000 #ffffaf
hi CursorLine   cterm=NONE              ctermbg=232
hi CursorColumn cterm=NONE              ctermbg=232
hi LineNr                   ctermfg=235

hi Directory                ctermfg=27                " #005fff

hi DiffAdd                  ctermfg=195 ctermbg=22    " #d7ffff #005f00
hi DiffChange               ctermfg=244 ctermbg=17    " #808080 #00005f
hi DiffDelete               ctermfg=195 ctermbg=52    " #d7ffff #5f0000
hi DiffText                 ctermfg=15  ctermbg=197   " #ffffff pinkish

hi ErrorMsg                 ctermfg=51  ctermbg=124   " #0000ff #af0000
hi WarningMsg               ctermfg=15  ctermbg=58    " #ffffff #5f5f00
hi SpellBad                 ctermfg=255 ctermbg=197   " #eeeeee reddishpurple

hi Folded                   ctermfg=122 ctermbg=233   " #87ffd7 #1c1c1c
hi FoldColumn               ctermfg=122 ctermbg=233   " #87ffd7 #1c1c1c
hi SignColumn               ctermfg=87  ctermbg=233   " #5fffff #1c1c1c
hi StatusLine   cterm=BOLD  ctermfg=122 ctermbg=233   " #87ffd7 #1c1c1c         
hi StatusLineNC cterm=NONE  ctermfg=242 ctermbg=233   " #6c6c6c #1c1c1c
hi VertSplit                ctermfg=173 ctermbg=16    " #d7875f #000000

hi ModeMsg      cterm=BOLD  ctermfg=120               " #87ff87
hi MoreMsg      cterm=BOLD  ctermfg=120               " #87ff87
hi Question     cterm=BOLD  ctermfg=120               " #87ff87

hi MatchParen   cterm=BOLD  ctermfg=16  ctermbg=49    " #000000 #00ffaf
hi IncSearch    cterm=NONE  ctermfg=15  ctermbg=24    " #ffffff #005f87
hi Search       cterm=NONE  ctermfg=15  ctermbg=234   " #ffffff #1c1c1c
hi Visual       cterm=BOLD  ctermfg=15  ctermbg=12    " #ffffff #00ffff

" Syntax
hi Comment                  ctermfg=210 ctermbg=232   " #ff8787 #080808

hi Constant                 ctermfg=204               " #ff5f87
hi String                   ctermfg=156               " #afff87
hi Character                ctermfg=149               " #afd75f
hi Number                   ctermfg=146               " #afafd7
hi Boolean                  ctermfg=111               " #87afff 
hi Float                    ctermfg=115               " #87d7af

hi Identifier               ctermfg=189               " #d7d7ff
hi Function                 ctermfg=222               " #ffd787

hi Statement                ctermfg=147               " #afafff
" subgroups: conditional, repeat, label, operator, keyword, exception

hi PreProc      cterm=BOLD  ctermfg=193               " #d7ffaf
hi Include      cterm=BOLD  ctermfg=195               " #d7ffff
hi Define       cterm=BOLD  ctermfg=193               " #d7ffaf
hi PreCondit    cterm=BOLD  ctermfg=209               " #ff875f

hi Type                     ctermfg=211               " #ff87af
hi StorageClass             ctermfg=183               " #d7afff
hi Structure                ctermfg=219               " #ffafff
hi Typedef                  ctermfg=210               " #ff8787

hi Special                  ctermfg=85                " #5fffaf
hi SpecialChar              ctermfg=159               " #afffff
hi SpecialKey               ctermfg=238 ctermbg=232
hi Tag                      ctermfg=49                " #00ffaf

hi Underlined  cterm=UNDERLINE  ctermfg=11            " #ffff00

hi Error       cterm=BOLD   ctermfg=15  ctermbg=124   " #ffffff #af0000 
hi Todo        cterm=BOLD   ctermfg=216 ctermbg=53    " #ffaf87 #5f005f

hi ColorColumn                          ctermbg=232

" vim-indent-guides
hi IndentGuidesOdd          ctermfg=233 ctermbg=232
hi IndentGuidesEven         ctermfg=233 ctermbg=16

" vim: set et :

