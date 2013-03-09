" Name:      galaxy vim colorscheme
" Author:    Vaz
" License:   public domain
" Created:   March 2012
" Modified:  March 2013


" {{{ Introduction
hi clear Normal
set background=dark
hi! clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "galaxy"

" }}}
" {{{ Colour functions

function! s:hex2rgb(hex)
  let hex = a:hex
  if hex[0] == '#' | let hex = hex[1:] | endif
  return [eval('0x'.hex[0:1]), eval('0x'.hex[2:3]), eval('0x'.hex[4:5])]
endfunction

function! s:rgb2xyz(rgb)
  " from http://www.cs.rit.edu/~ncs/color/t_convert.html#RGB%20to%20XYZ%20&%20XYZ%20to%20RGB
  let [r, g, b] = a:rgb
  let x = 0.412453 * r + 0.357580 * g + 0.180423 * b
  let y = 0.212671 * r + 0.715160 * g + 0.072169 * b
  let z = 0.019334 * r + 0.119193 * g + 0.950227 * b
  return [x, y, z]
endfunction

function! s:xyz2256(xyz)
  let [x, y, z] = a:xyz
  return 16 + (x * 36) + (y * 6) + z
endfunction

function! s:get_gui(key) dict
  if a:key ==? 'fg' || a:key ==? 'bg' || a:key ==? 'none' | return a:key | endif
  return get(get(self, a:key, {}), 'gui', 'NONE')
endfunction

function! s:get_cterm(key) dict
  if a:key ==? 'fg' || a:key ==? 'bg' || a:key ==? 'none' | return a:key | endif
  if has_key(self, a:key)
    let c = self[a:key]
    if &t_Co > 255
      if has_key(c, '256')
        return c['256']
      elseif has_key(c, 'gui')
        return xyz2256(rgb2xyz(hex2rgb(c.gui)))
      endif
    elseif &t_Co > 87
      return get(c, '88', 'NONE')
    else
      return get(c, '16', 'NONE')
    endif
  endif
endfunction

function! Colours(d)
  let a:d['gui']   = function('s:get_gui')
  let a:d['cterm'] = function('s:get_cterm')
  return a:d
endfunction

let s:colours = Colours({
  \   'b0':          { 'gui': "#0a0f30", '16': 'NONE', 'comment': 'background'           }
  \ , 'b1':          { 'gui': "#2a233b", '16': '0',    'comment': '0;30 (black)'         }
  \ , 'b2':          { 'gui': "#657090", '16': '8',    'comment': '1;30 (bright black)'  }
  \ , 'b3':          { 'gui': "#b7c6e0", '16': '7',    'comment': '0;37 (white)'         }
  \ , 'b4':          { 'gui': "#f0f9ff", '16': '15',   'comment': '1;37 (bright white)'  }
  \ , 'magenta':     { 'gui': "#ff9ab0", '16': '1',    'comment': '0;31 (red)'           }
  \ , 'green':       { 'gui': "#30ff70", '16': '2',    'comment': '0;32 (green)'         }
  \ , 'yellow':      { 'gui': "#a9ff25", '16': '3',    'comment': '0;33 (yellow)'        }
  \ , 'blue':        { 'gui': "#60c0ff", '16': '4',    'comment': '0;34 (blue)'          }
  \ , 'purple':      { 'gui': "#e08aff", '16': '5',    'comment': '0;35 (magenta)'       }
  \ , 'cyan':        { 'gui': "#70ffb6", '16': '6',    'comment': '0;36 (cyan)'          }
  \ , 'pmagenta':    { 'gui': "#ffd0e8", '16': '9',    'comment': '1;31 (bright red)'    }
  \ , 'pgreen':      { 'gui': "#bcffd3", '16': '10',   'comment': '1;32 (bright green)'  }
  \ , 'pyellow':     { 'gui': "#d0ff80", '16': '11',   'comment': '1;33 (bright yellow)' }
  \ , 'pblue':       { 'gui': "#c5d0ff", '16': '12',   'comment': '1;34 (bright blue)'   }
  \ , 'ppurple':     { 'gui': "#e7baff", '16': '13',   'comment': '1;35 (bright purple)' }
  \ , 'pcyan':       { 'gui': "#b4ffe4", '16': '14',   'comment': '1;36 (bright cyan)'   }
  \
  \ , 'dgreen':      { 'gui': "#357958", '16': '2',    'comment': 'dark green for diff'  }
  \ , 'dblue':       { 'gui': "#455FB0", '16': '4',    'comment': 'dark blue for diff'   }
  \ , 'dmagenta':    { 'gui': "#8C3B85", '16': '1',    'comment': 'dark magenta for diff'}
  \ , 'dpurple':     { 'gui': "#5838A8", '16': '5',    'comment': 'dark purple for diff'}
  \ })

" }}}
" quick command {{{

command! -nargs=+ -complete=highlight -bar -bang Hi call <sid>HiLite("<bang>", <f-args>)
" HiLite Comment fg=magenta bg=NONE attr=undercurl sp=magenta font=Monaco:h14
function! s:HiLite(bang, ...)
  let groups = []
  let cmd = []

  for arg in a:000
    let parts = split(arg, '=')
    if len(parts) > 1
      let [k, v] = [parts[0], join(parts[1:], '=')]
      if k ==? 'fg' || k ==? 'bg'
        call add(cmd, 'gui'.k.'='.s:colours.gui(v))
        if !(v ==? 'fg' || v ==? 'bg') ||
              \ synIDattr(synIDtrans(hlID('Normal')), v, 'cterm') != -1
          call add(cmd, 'cterm'.k.'='.s:colours.cterm(v))
        endif
      elseif k ==? 'sp'
        call add(cmd, 'gui'.k.'='.s:colours.gui(v))
      elseif k ==? 'attr'
        call add(cmd, 'gui='.v)
        call add(cmd, 'cterm='.v)
        call add(cmd, 'term='.v)
      else
        call add(cmd, arg)
      endif
    else
      call add(groups, arg)
    endif
  endfor

  if empty(groups)
    return
  endif

  exec "hi".a:bang." ".groups[0]." ".join(cmd, " ")

  for group in groups[1:]
    exec "hi".a:bang." ".group." ".join(cmd, " ")
  endfor
endfunction

" }}}
" {{{ General colors

Hi Normal fg=b3 bg=b0
Hi NonText fg=b1
hi! link SpecialKey NonText

Hi Cursor fg=b1 bg=b4 attr=bold

Hi GalaxyFrame fg=b2 bg=b1
Hi GalaxyFrameItalic fg=b2 bg=b1 attr=italic

hi! link LineNr GalaxyFrame
hi! link SignColumn GalaxyFrame
hi! link FoldColumn GalaxyFrameItalic
hi! link Folded FoldColumn

hi! link VertSplit GalaxyFrame

hi! link StatusLineNC GalaxyFrame
Hi StatusLine fg=b3 bg=b1 attr=bold

Hi Title fg=pgreen attr=italic
Hi Visual fg=b1 bg=ppurple attr=bold

Hi WildMenu fg=green bg=b1
Hi Ignore fg=b1

Hi Error fg=pmagenta bg=b0 attr=undercurl,bold sp=magenta
Hi ErrorMsg fg=b4 bg=dmagenta attr=bold
Hi WarningMsg fg=b4 bg=dpurple

Hi ModeMsg fg=pgreen attr=bold

Hi Directory fg=blue attr=bold
Hi Question fg=green attr=bold
Hi MoreMsg fg=pgreen attr=italic

Hi SpellBad attr=undercurl sp=magenta
Hi SpellCap attr=undercurl sp=blue
Hi SpellRare attr=undercurl sp=purple
Hi SpellLocal attr=undercurl sp=cyan

Hi CursorLine bg=b1
Hi CursorColumn bg=b1
Hi ColorColumn bg=b1
Hi MatchParen fg=b4 bg=dblue attr=bold
Hi Pmenu fg=b4 bg=b1
Hi PmenuSel fg=yellow bg=b1 attr=bold
Hi PmenuSbar fg=b4 bg=b2
Hi Search fg=b4 bg=b1 attr=bold,italic
Hi IncSearch fg=b4 bg=b1 attr=bold,italic

" }}}
" {{{ General Syntax highlighting
Hi Comment fg=b2 attr=italic

Hi String fg=pgreen
Hi Number fg=ppurple

Hi Statement fg=pblue attr=bold
Hi PreProc fg=pblue

" TODO:
Hi Todo fg=b4 bg=b1

Hi Constant fg=ppurple
Hi Function fg=ppurple

Hi Identifier fg=blue
Hi Type fg=pmagenta

Hi Special fg=green
Hi Delimiter fg=cyan
Hi Operator fg=b4

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

Hi DiffAdd fg=fg bg=dgreen attr=bold
Hi DiffChange fg=fg bg=dblue attr=bold
Hi DiffDelete fg=fg bg=dmagenta attr=bold
Hi DiffText fg=fg bg=dpurple attr=bold

" }}}
" {{{ Special for Ruby

Hi rubyRegexp fg=purple
Hi rubyRegexpDelimiter fg=pmagenta
Hi rubyRegexpSpecial fg=pmagenta
Hi rubyEscape fg=b4
Hi rubyInterpolation fg=pgreen attr=italic
Hi rubyInterpolationDelimiter fg=pmagenta
Hi rubyControl fg=pblue
hi link rubyConditional rubyControl
Hi rubyGlobalVariable fg=magenta
Hi rubyStringDelimiter fg=cyan
Hi rubyBlockParameterList fg=pmagenta
Hi rubyBlockParameter fg=b4
Hi rubyDelimiter fg=b4
Hi rubyLocalVariableOrMethod fg=b4
Hi rubySymbol fg=magenta
Hi rubyPredefinedIdentifier fg=pmagenta
Hi rubyPseudoVariable fg=pmagenta attr=italic
Hi rubyInclude fg=pmagenta
Hi rubyFunction fg=b4

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

Hi pythonPrecondit fg=pmagenta attr=italic

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

Hi EasyMotionTarget fg=pmagenta
Hi EasyMotionShade fg=b0 bg=#000000

" }}}
" {{{ Indent Guides
exec "hi IndentGuidesOdd  guibg=#040729"
exec "hi IndentGuidesEven guibg=#1d213e"
" }}}


