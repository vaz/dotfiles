" Autosource
"
" Toggle automatic sourcing of vim files upon write.
" Useful for vimrc/init.vim, colour schemes, vim plugin development.
"
" Basically, sets up autocmds in a group called "autocmd"
" source after being saved (event BufWritePost).
"
"
" Created by Vaz Allen / public domain

" Setup   {{{
"""""""""""""

let s:group = "autosource"
let s:event = "BufWritePost"

" Make sure the group exists
if !exists("#autosource")
  exe "aug " . e:group
  aug end
endif

" }}}
" Utility functions {{{
"""""""""""""""""""""""

fun! s:exists(path)
  return exists("#" . s:group . "#" . s:event . "#" . expand(a:path))
endfun

fun! s:log(msg)
  echom "[Autosource] " . a:msg
endfun

fun! s:add(path, cmd)
  if s:exists(a:path)
    return 0
  else
    exe join(["au!", s:group, s:event, expand(a:path), "nested", a:cmd], " ")
    return 1
  end
endfun

fun! s:remove(path)
  if s:exists(a:path)
    exe join(["au!", s:group, s:event, expand(a:path)], " ")
    return 1
  else
    return 0
  endif
endfun

" }}}
" Autoload functions {{{
""""""""""""""""""""""""
try
  " if w or a in shortmess, shorten
  " get last line of output from :w, append [autosourced] or [so]
  " echohl?
  " don't noautocmd write, can't interfere with other autos
  fun! autosource#source(path) abort
    let l:path = expand(a:path)
    exe "source " . l:path
    call s:log("sourced " . l:path)
  endfun
catch /^Vim\%((\a\+)\)\=:E127/
  " error when autosourcing this file, can't redefine executing function
endtry

fun! autosource#enable(path) abort
  let l:path = expand(a:path)
  if s:add(l:path, "call autosource#source(\"<afile>\")")
    call s:log("enabled: " . l:path)
  else
    call s:log("already enabled: " . l:path)
  endif
endfun

fun! autosource#disable(path) abort
  let l:path = expand(a:path)
  if s:remove(l:path)
    call s:log("disabled for " . l:path)
  else
    call s:log("already disabled: " . l:path)
  endif
endfun

fun! autosource#toggle(path) abort
  if s:exists(a:path)
    call autosource#disable(a:path)
  else
    call autosource#enable(a:path)
  endif
endfun

fun! autosource#list() abort
  exe "au " . s:group
endfun

fun! autosource#clear() abort
  exe "au! " . s:group
  call s:log("cleared all rules")
endfun

fun! autosource#command(path, bang)
  let l:path = expand(a:path)
  if empty(l:path)
    if a:bang ==# "!"
      call autosource#clear()
    else
      call autosource#list()
    endif
  else
    call autosource#toggle(l:path)
  endif
endfun

" }}}
" Modeline {{{
" -*- vim -*- vim:set ft=vim et sw=2 sts=2 fdls=1 fdm=marker fdl=999:
