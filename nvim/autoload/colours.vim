
fun! colours#clearbg()
  hi Normal ctermbg=none guibg=none
endfun

if !exists('g:colours#definitions')
  let g:colours#definitions = { 'default': 'set bg=dark | colors default' }
endif

let s:current = 'default'

fun! colours#activate(name)
  if has_key(g:colours#definitions, a:name)
    exe g:colours#definitions[a:name]
    let s:current = a:name
  else
    echoerr "colourscheme not defined, check colours#definitions"
  endif
endfun

fun! s:colourscompl(ArgLead, CmdLine, CursorPos)
  return keys(g:colours#definitions)
endfun

command! -nargs=1 -complete=customlist,s:colourscompl Colours call colours#activate("<args>")

fun! s:colourscycle()
  let l:keys = keys(g:colours#definitions)
  if has_key(g:colours#definitions, s:current)
    let l:next_index = (index(l:keys, s:current) + 1) % len(l:keys)
    call colours#activate(get(l:keys, l:next_index))
  else
    call colours#activate(get(l:keys, 0))
  endif
endfun

nnoremap <silent> <Plug>coloursCycle :call <SID>colourscycle()<cr>
