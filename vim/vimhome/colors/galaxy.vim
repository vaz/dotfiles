" Name: galaxy vim colorscheme
" Author: Vaz
" License: public domain
" Created: March 2012
" Modified: March 2012


" {{{ Introduction
hi clear
set background=dark

if exists("syntax_on")
  syntax reset
endif

let colors_name = "galaxy"
" }}}
" {{{ Colour RGB table
" This is probably out of date now.
"                 RGB         Hex
" background    7/  5/ 25   #070519
" br black     42/ 35/ 59   #2a233b
" black       101/112/144   #657090
" white       183/198/224   #b7c6e0
" br white    240/249/255   #f0f9ff

"                       DARK                      BRIGHT
"                 RGB         Hex           RGB         Hex
" magenta     255/ 42/128   #ff2a80     255/128/196   #ff80c4
" green        48/255/112   #30ff70     144/255/150   #90ff96
" yellow      169/255/ 37   #a9ff25     208/255/128   #d0ff80
" blue         73/128/255   #4980ff     155/192/255   #9bc0ff
" purple      208/ 90/255   #d05aff     233/186/255   #e7baff
" cyan        112/255/182   #70ffb6     180/255/228   #b4ffe4
" }}}
" {{{ Colour variables

" base colours
let s:bg = "#0a0f30"  " background
let s:b0 = "#2a233b"  " 0;30 (black)
let s:b1 = "#657090"  " 1;30 (bright black)
let s:b2 = "#b7c6e0"  " 0;37 (white)
let s:b3 = "#f0f9ff"  " 1;37 (bright white)

" highlights
let s:magenta = "#ff9ab0"   " 0;31 (red)
let s:green   = "#30ff70"   " 0;32 (green)
let s:yellow  = "#a9ff25"   " 0;33 (yellow)
let s:blue    = "#60c0ff"   " 0;34 (blue)
let s:purple  = "#e08aff"   " 0;35 (magenta)
let s:cyan    = "#70ffb6"   " 0;36 (cyan)

" pale colours
let s:p_magenta = "#ffd0e8" " 1;31 (bright red)
let s:p_green   = "#bcffd3" " 1;32 (bright green)
let s:p_yellow  = "#d0ff80" " 1;33 (bright yellow)
let s:p_blue    = "#c5d0ff" " 1;34 (bright blue)
let s:p_purple  = "#e7baff" " 1;35 (bright purple)
let s:p_cyan    = "#b4ffe4" " 1;36 (bright cyan)

" }}}
" {{{ General colors

exec "hi Normal           guifg=".s:b3."        guibg=".s:bg."        gui=NONE"

exec "hi NonText          guifg=".s:b1."        guibg=NONE            gui=NONE"

exec "hi Cursor           guifg=".s:b0."        guibg=".s:b3."        gui=bold"
exec "hi LineNr           guifg=".s:b1."        guibg=".s:b0."        gui=NONE"

exec "hi VertSplit        guifg=".s:b1."        guibg=".s:b0."        gui=NONE"
exec "hi StatusLine       guifg=".s:b2."        guibg=".s:b0."        gui=bold"
exec "hi StatusLineNC     guifg=".s:b1."        guibg=".s:b0."        gui=NONE"

exec "hi Folded           guifg=".s:b1."        guibg=".s:b0."        gui=italic"
exec "hi FoldColumn       guifg=".s:b1."        guibg=".s:b0."        gui=italic"
exec "hi Title            guifg=".s:p_green."   guibg=NONE            gui=italic"
exec "hi Visual           guifg=".s:b0."        guibg=".s:p_purple."  gui=bold"

exec "hi SpecialKey       guifg=".s:b1."        guibg=NONE            gui=bold"

exec "hi WildMenu         guifg=".s:green."     guibg=".s:b0."        gui=NONE"
exec "hi Ignore           guifg=".s:b0."        guibg=NONE            gui=NONE"

exec "hi Error            guifg=NONE            guibg=NONE            gui=undercurl guisp=".s:magenta
exec "hi ErrorMsg         guifg=".s:b0."        guibg=".s:magenta."   gui=bold"
exec "hi WarningMsg       guifg=".s:b3."        guibg=".s:purple."    gui=NONE"

exec "hi ModeMsg          guifg=".s:p_green."   guibg=NONE            gui=BOLD"

exec "hi Directory        guifg=".s:blue."      guibg=NONE            gui=BOLD"
exec "hi Question         guifg=".s:green."     guibg=NONE            gui=BOLD"
exec "hi MoreMsg          guifg=".s:p_green."     guibg=NONE            gui=italic"

exec "hi SpellBad         gui=undercurl guisp=".s:magenta
exec "hi SpellCap         gui=undercurl guisp=".s:blue
exec "hi SpellRare        gui=undercurl guisp=".s:purple
exec "hi SpellLocal       gui=undercurl guisp=".s:cyan

if version >= 700 " Vim 7.x specific colors
  exec "hi CursorLine     guifg=NONE            guibg=".s:b0."        gui=NONE"
  exec "hi CursorColumn   guifg=NONE            guibg=".s:b0."        gui=NONE"
  exec "hi ColorColumn    guifg=NONE            guibg=".s:b0."        gui=NONE"
  exec "hi MatchParen     guifg=".s:magenta."   guibg=NONE            gui=BOLD"
  exec "hi Pmenu          guifg=".s:b3."        guibg=".s:b0."        gui=NONE"
  exec "hi PmenuSel       guifg=".s:yellow."    guibg=".s:b0."        gui=bold"
  exec "hi PmenuSbar      guifg=".s:b3."        guibg=".s:b2."        gui=NONE"
  exec "hi Search         guifg=".s:b3."        guibg=".s:b0."        gui=bold,italic"
  exec "hi IncSearch      guifg=".s:b3."        guibg=".s:b0."        gui=bold,italic"
endif
" }}}
" {{{ General Syntax highlighting
exec "hi Comment          guifg=".s:b1."        guibg=NONE            gui=italic"
exec "hi String           guifg=".s:p_green."   guibg=NONE            gui=NONE"
exec "hi Number           guifg=".s:p_purple."  guibg=NONE            gui=NONE"

exec "hi Statement        guifg=".s:p_blue."    guibg=NONE            gui=bold"

exec "hi PreProc          guifg=".s:p_blue."    guibg=NONE            gui=NONE"

" TODO:
exec "hi Todo             guifg=".s:magenta."   guibg=".s:b0."        gui=NONE"

exec "hi Constant         guifg=".s:p_purple."  guibg=NONE            gui=NONE"
exec "hi Function         guifg=".s:p_purple."        guibg=NONE            gui=NONE"

exec "hi Identifier       guifg=".s:blue."      guibg=NONE            gui=NONE"
exec "hi Type             guifg=".s:p_magenta." guibg=NONE            gui=NONE"

exec "hi Special          guifg=".s:green."    guibg=NONE             gui=NONE"
exec "hi Delimiter        guifg=".s:cyan."      guibg=NONE            gui=NONE"
exec "hi Operator         guifg=".s:b3."w       guibg=NONE            gui=NONE"

hi link Character       Constant
hi link Boolean         Constant
hi link Float           Number
hi link Repeat          Statement
hi link Label           Statement
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link SpecialChar     Special
hi link SpecialComment  Special
hi link Debug           Special
" }}}
" {{{ Diff Colours
exec "hi DiffAdd          guifg=".s:b0."    guibg=".s:blue."      gui=NONE"
exec "hi DiffChange       guifg=".s:b0."    guibg=".s:purple."    gui=NONE"
exec "hi DiffDelete       guifg=".s:b3."    guibg=".s:magenta."   gui=NONE"
" }}}
" {{{ Special for Ruby
"hi rubyRegexp                  guifg=#B18A3D      guibg=NONE      gui=NONE      ctermfg=brown          ctermbg=NONE      cterm=NONE
"hi rubyRegexpDelimiter         guifg=#FF8000      guibg=NONE      gui=NONE      ctermfg=brown          ctermbg=NONE      cterm=NONE
exec "hi rubyRegexpSpecial      guifg=".s:p_magenta."    guibg=NONE       gui=NONE"
"hi rubyEscape                  guifg=white        guibg=NONE      gui=NONE      ctermfg=cyan           ctermbg=NONE      cterm=NONE
exec "hi rubyInterpolation          guifg=".s:p_green."    guibg=NONE  gui=italic"
exec "hi rubyInterpolationDelimiter guifg=".s:p_magenta."      guibg=NONE  gui=NONE"
exec "hi rubyControl                guifg=".s:p_blue."    guibg=NONE  gui=NONE"
exec "hi rubyConditional            guifg=".s:p_blue."    guibg=NONE  gui=NONE"
exec "hi rubyGlobalVariable         guifg=".s:magenta."   guibg=NONE  gui=NONE"
exec "hi rubyStringDelimiter        guifg=".s:cyan."      guibg=NONE  gui=NONE"
exec "hi rubyBlockParameterList     guifg=".s:p_magenta." guibg=NONE  gui=NONE"
exec "hi rubyBlockParameter         guifg=".s:b3."        guibg=NONE  gui=NONE"
exec "hi rubyDelimiter              guifg=".s:cyan."      guibg=NONE  gui=NONE"
exec "hi rubyLocalVariableOrMethod  guifg=".s:b3."        guibg=NONE  gui=NONE"
exec "hi rubySymbol                 guifg=".s:magenta."  guibg=NONE  gui=NONE"
exec "hi rubyPredefinedIdentifier   guifg=".s:p_magenta."    guibg=NONE  gui=NONE"
exec "hi rubyPseudoVariable         guifg=".s:p_magenta."        guibg=NONE  gui=italic"
exec "hi rubyInclude                guifg=".s:p_magenta." guibg=NONE  gui=italic"
exec "hi rubyFunction               guifg=".s:b3."        guibg=NONE  gui=NONE"

""rubyInclude
""rubySharpBang
""rubyAccess
""rubyPredefinedVariable
""rubyBoolean
""rubyClassVariable
""rubyBeginEnd
""rubyRepeatModifier
""hi link rubyArrayDelimiter    Special  " [ , , ]
""rubyCurlyBlock  { , , }

hi link rubyClass             Keyword 
hi link rubyModule            Keyword 
hi link rubyKeyword           Keyword 
hi link rubyOperator          Operator
hi link rubyBoolean           rubyPseudoVariable
hi link rubyIdentifier        Identifier
hi link rubyInstanceVariable  Identifier
hi link rubyGlobalVariable    Identifier
hi link rubyClassVariable     Identifier
hi link rubyConstant          Constant
hi link rubyMethodDeclaration rubyFunction
hi link rubyArrayDelimiter    rubyDelimiter
hi link rubyDefine            rubyClass
hi link rubyModule            rubyClass
" }}}
" {{{ Python
exec "hi pythonPrecondit            guifg=".s:p_magenta." guibg=NONE  gui=italic"
" }}}
" {{{ XML and HTML
hi link xmlTag          Keyword 
hi link xmlTagName      Conditional 
hi link xmlEndTag       Identifier 
hi link htmlTag         xmlTag
hi link htmlTagName     xmlTagName
hi link htmlEndTag      xmlEndTag
" }}}
" {{{ JS
hi link javaScriptNumber      Number 
" }}}
" {{{ EasyMotion
exec "hi EasyMotionTarget guifg=".s:magenta."   guibg=NONE            gui=bold"
exec "hi EasyMotionShade  guifg=".s:b1."        guibg=NONE            gui=bold"
" }}}
" {{{ Indent Guides
exec "hi IndentGuidesOdd  guibg=#040729"
exec "hi IndentGuidesEven guibg=#1d213e"
" }}}


