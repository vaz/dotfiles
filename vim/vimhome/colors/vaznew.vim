" vaz vim color file
" for 256 and 16 colour terminals

set background=dark

hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "vaz"

hi Normal       cterm=NONE  ctermfg=229 ctermbg=17    " #ffffaf #00005f
hi NonText                  ctermfg=65                " 5f875f

hi Cursor       cterm=NONE  ctermfg=16  ctermbg=229   " #000000 #ffffaf
hi CursorLine                           ctermbg=23    "         #005f5f

hi Directory                ctermfg=27                " #005fff

hi DiffAdd                  ctermfg=195 ctermbg=22    " #d7ffff #005f00
hi DiffChange               ctermfg=244 ctermbg=17    " #808080 #00005f
hi DiffDelete               ctermfg=195 ctermbg=52    " #d7ffff #5f0000
hi DiffText                 ctermfg=15                " #ffffff 

hi ErrorMsg                 ctermfg=51  ctermbg=124   " #0000ff #af0000

hi VertSplit                ctermfg=173 ctermbg=16    " #d7875f #000000
hi Folded                   ctermfg=122 ctermbg=233   " #87ffd7 #1c1c1c
hi FoldColumn               ctermfg=122 ctermbg=233   " #87ffd7 #1c1c1c
hi SignColumn               ctermfg=87  ctermbg=233   " #5fffff #1c1c1c
hi ModeMsg      cterm=BOLD  ctermfg=120               " #87ff87
hi MoreMsg      cterm=BOLD  ctermfg=120               " #87ff87
hi Question     cterm=BOLD  ctermfg=120               " #87ff87
hi LineNr   cterm=UNDERLINE ctermfg=86                " #5fffd7
hi MatchParen   cterm=BOLD  ctermfg=16  ctermbg=49    " #000000 #00ffaf

hi IncSearch    cterm=NONE  ctermfg=15  ctermbg=24    " #ffffff #005f87
hi Search       cterm=NONE  ctermfg=15  ctermbg=234   " #ffffff #1c1c1c




StatusLine
StatusLineNC        " non-current windows
Visual
WarningMsg
WildMenu


" Syntax
Comment

Constant
String
Character
Number
Boolean
Float

Identifier        " Any variable name
Function

Statement
Conditional       " if, switch, etc
Repeat            " for, while, etc
Label             " case, default, etc
Operator          " sizeof, +, etc
Keyword           " any other keyword
Exception         " try, catch, throw

PreProc           " any preprocessor
Include           " #include
Define            " #define
PreCondit         " preprocessor #if etc

Type              " int, long, char, etc
StorageClass      " static, register, etc
Structure         " struct, union, etc
Typedef           " typedef

Special           " any special symbol
SpecialChar       " special char in a constant
Tag               " can use CTRL-] on this
Delimiter         " character that needs attention
SpecialComment    " special things inside a comment
Debug             " debugging statements

Underlined        " text that stands out, links

Ignore            " left blank, hidden

Error             " any erroneous construct

Todo              " TODO, FIXME, etc




if has("gui_running")
    hi Normal         term=NONE  gui=NONE  guifg=#fff3ce   guibg=#000715

    hi IncSearch      gui=BOLD  guifg=#ffffff   guibg=#00040f
    hi Search         gui=NONE  guifg=#ffffff   guibg=#00041d
    hi ErrorMsg       gui=BOLD   guifg=#ffffff   guibg=#ff0000
    hi WarningMsg     gui=BOLD   guifg=#ffffff   guibg=#ffff00
    hi ModeMsg        gui=BOLD   guifg=#c9e6ff   guibg=NONE
    hi MoreMsg        gui=BOLD   guifg=#c9e6ff   guibg=NONE
    hi Question       gui=BOLD   guifg=#ffcd00   guibg=NONE
    hi StatusLine     gui=BOLD   guifg=#b9b9b9   guibg=#3e3e5e
    hi User1          gui=BOLD   guifg=#00ff8b   guibg=#3e3e5e
    hi User2          gui=BOLD   guifg=#7070a0   guibg=#3e3e5e
    hi StatusLineNC   gui=NONE   guifg=#b9b9b9   guibg=#3e3e5e
    hi VertSplit      gui=NONE   guifg=#b9b9b9   guibg=#3e3e5e

    hi WildMenu       gui=BOLD   guifg=#eeeeee   guibg=#6e6eaf

    hi MBENormal                 guifg=#cfbfad   guibg=#2e2e3f
    hi MBEChanged                guifg=#eeeeee   guibg=#2e2e3f
    hi MBEVisibleNormal          guifg=#cfcfcd   guibg=#4e4e8f
    hi MBEVisibleChanged         guifg=#eeeeee   guibg=#4e4e8f

    hi DiffText       gui=NONE   guifg=#ffffcd   guibg=#4a2a4a
    hi DiffChange     gui=NONE   guifg=#ffffcd   guibg=#306b8f
    hi DiffDelete     gui=NONE   guifg=#ffffcd   guibg=#6d3030
    hi DiffAdd        gui=NONE   guifg=#ffffcd   guibg=#306d30

    hi Cursor         gui=NONE   guifg=#404040   guibg=#8b8bff
    hi lCursor        gui=NONE   guifg=#404040   guibg=#8fff8b
    hi CursorIM       gui=NONE   guifg=#404040   guibg=#8b8bff

    hi Folded         gui=NONE   guifg=#cfcfcd   guibg=#4b208f
    hi FoldColumn     gui=NONE   guifg=#8b8bcd   guibg=#2e2e2e

    hi Directory      gui=NONE   guifg=#00ff8b   guibg=NONE
    hi LineNr         gui=NONE   guifg=#8b8bcd   guibg=#2e2e2e
    hi NonText        gui=BOLD   guifg=#8b8bcd   guibg=NONE
    hi SpecialKey     gui=BOLD   guifg=#ab60ed   guibg=NONE
    hi Title          gui=BOLD   guifg=#af4f4b   guibg=NONE
    hi Visual         gui=NONE   guifg=#eeeeee   guibg=#4e4e8f
    " this is a comment
    hi Comment        gui=NONE   guifg=#ff9dbf   guibg=#040003
    hi Constant       gui=NONE   guifg=#e0ccff   guibg=NONE
    hi String         gui=NONE   guifg=#b5ff84   guibg=NONE
    hi Error          gui=NONE   guifg=#ffffff   guibg=#8e2e2e
    hi Identifier     gui=NONE   guifg=#ff8bff   guibg=NONE
    hi Ignore         gui=NONE
    hi Number         gui=NONE   guifg=#b3e0ff   guibg=NONE
    hi PreProc        gui=NONE   guifg=#e5fff9   guibg=NONE
    hi Special        gui=NONE   guifg=#ffbb22   guibg=NONE
    hi SpecialChar    gui=NONE   guifg=#ffbb22   guibg=NONE
    hi Statement      gui=NONE   guifg=#c3e6ff   guibg=NONE
    hi Todo           gui=BOLD   guifg=#303030   guibg=#d0a060
    hi Type           gui=NONE   guifg=#ffaeb6   guibg=NONE
    hi Underlined     gui=BOLD   guifg=#df9f2d   guibg=NONE
    hi TaglistTagName gui=BOLD   guifg=#808bed   guibg=NONE

    hi cSpecialCharacter  gui=NONE guifg=#90e7ff   guibg=NONE
    hi cFormat            gui=NONE guifg=#90e7ff   guibg=NONE

    if v:version >= 700
        hi Pmenu          gui=NONE   guifg=#eeeeee   guibg=#4e4e8f
        hi PmenuSel       gui=BOLD   guifg=#eeeeee   guibg=#2e2e3f
        hi PmenuSbar      gui=BOLD   guifg=#eeeeee   guibg=#6e6eaf
        hi PmenuThumb     gui=BOLD   guifg=#eeeeee   guibg=#6e6eaf

        hi SpellBad     gui=undercurl guisp=#cc6666
        hi SpellRare    gui=undercurl guisp=#cc66cc
        hi SpellLocal   gui=undercurl guisp=#cccc66
        hi SpellCap     gui=undercurl guisp=#66cccc

        hi MatchParen   gui=NONE      guifg=#404040   guibg=#8fff8b
    endif
  else

    hi Normal            ctermfg=Grey      ctermbg=NONE

    hi IncSearch         ctermfg=White     ctermbg=Blue
    hi Search            ctermfg=White     ctermbg=Blue
    hi ErrorMsg          ctermfg=White     ctermbg=Red
    hi WarningMsg        ctermfg=White     ctermbg=Yellow
    hi ModeMsg           ctermfg=Cyan      ctermbg=NONE
    hi MoreMsg           ctermfg=Cyan      ctermbg=NONE
    hi Question          ctermfg=Yellow    ctermbg=NONE

    hi StatusLine        ctermfg=Grey      ctermbg=Blue
    hi User1             ctermfg=DarkCyan  ctermbg=Blue
    hi User2             ctermfg=Grey      ctermbg=Blue
    hi StatusLineNC      ctermfg=Grey      ctermbg=Blue
    hi VertSplit         ctermfg=Grey      ctermbg=Blue

    hi WildMenu          ctermfg=White     ctermbg=Blue

    hi MBENormal         ctermfg=Grey      ctermbg=NONE
    hi MBEChanged        ctermfg=White     ctermbg=NONE
    hi MBEVisibleNormal  ctermfg=Grey      ctermbg=NONE
    hi MBEVisibleChanged ctermfg=White     ctermbg=Blue

    hi DiffText          ctermfg=Yellow    ctermbg=Magenta
    hi DiffChange        ctermfg=Yellow    ctermbg=Cyan
    hi DiffDelete        ctermfg=Yellow    ctermbg=Red
    hi DiffAdd           ctermfg=Yellow    ctermbg=Green

    hi Cursor            ctermfg=DarkGrey  ctermbg=Blue
    hi lCursor           ctermfg=DarkGrey  ctermbg=Green
    hi CursorIM          ctermfg=DarkGrey  ctermbg=Blue

    hi Folded            ctermfg=Grey      ctermbg=Blue
    hi FoldColumn        ctermfg=Blue      ctermbg=NONE

    hi Directory         ctermfg=DarkCyan  ctermbg=NONE
    hi LineNr            ctermfg=DarkCyan  ctermbg=NONE
    hi NonText           ctermfg=DarkCyan  ctermbg=NONE
    hi SpecialKey        ctermfg=Magenta   ctermbg=NONE
    hi Title             ctermfg=Red       ctermbg=NONE
    hi Visual            ctermfg=White     ctermbg=Blue

    hi Comment           ctermfg=Magenta   ctermbg=NONE
    hi Constant          ctermfg=Magenta   ctermbg=NONE
    hi String            ctermfg=Green     ctermbg=NONE
    hi Error             ctermfg=White     ctermbg=Red
    hi Identifier        ctermfg=Cyan      ctermbg=NONE
    hi Ignore         
    hi Number            ctermfg=Cyan      ctermbg=NONE
    hi PreProc           ctermfg=DarkCyan  ctermbg=NONE
    hi Special           ctermfg=DarkGreen ctermbg=NONE
    hi SpecialChar       ctermfg=DarkGreen ctermbg=NONE
    hi Statement         ctermfg=Cyan      ctermbg=NONE
    hi Todo              ctermfg=Red       ctermbg=Yellow
    hi Type              ctermfg=Red       ctermbg=NONE
    hi Underlined        ctermfg=Yellow    ctermbg=NONE
    hi TaglistTagName    ctermfg=Blue      ctermbg=NONE

    hi cSpecialCharacter ctermfg=DarkGreen ctermbg=NONE
    hi cFormat           ctermfg=DarkGreen ctermbg=NONE

    if v:version >= 700
        hi Pmenu         ctermfg=White     ctermbg=Cyan
        hi PmenuSel      ctermfg=White     ctermbg=Blue
        hi PmenuSbar     ctermfg=White     ctermbg=Cyan
        hi PmenuThumb    ctermfg=White     ctermbg=Cyan

        hi MatchParen    ctermfg=DarkGrey  ctermbg=Green
    endif
  endif

" vim: set et :






