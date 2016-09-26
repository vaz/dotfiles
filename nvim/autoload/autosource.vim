if !exists("#autosource")
  aug autosource
  aug end
endif

try
  fun! autosource#source(path) abort
    let l:path = expand(a:path)
    exe "source " . l:path
    echom "Autosourced " . l:path
  endfun
catch /^Vim\%((\a\+)\)\=:E127/
endtry

fun! autosource#toggle(path) abort
  let l:path = expand(a:path)
  if exists("#autosource#BufWritePost#" . l:path)
    call autosource#disable(l:path)
  else
    call autosource#enable(l:path)
  endif
endfun

fun! autosource#enable(path) abort
  let l:path = expand(a:path)
  exe "au! autosource BufWritePost " . l:path . " call autosource#source(\"<afile>\")"
  echom "autosource enabled for " . l:path
endfun

fun! autosource#disable(path) abort
  let l:path = expand(a:path)
  exe "au! autosource BufWritePost " . l:path
  echom "autosource disabled for " . l:path
endfun

fun! autosource#showpaths() abort
  exe "au autosource"
endfun

fun! autosource#clear() abort
  exe "au! autosource"
endfun

fun! autosource#command(path)
  let l:path = expand(a:path)
  if empty(l:path)
    call autosource#showpaths()
  else
    call autosource#toggle(l:path)
  endif
endfun

command! -nargs=? Autosource call autosource#command(<q-args>)

