" lecture mode
" see enew, vert, above, bot, etc
" 'preview*', find, path, gf, ...
fun! LectureModeSlide(mod) abort
  let l:file = expand('%')
  let l:curr = str2nr(substitute(l:file, '\v^.*([0-9]+),.*', '\1', ''))
  let l:next = l:curr + a:mod
  if l:next < 0
    let l:next = 0
  endif
  let l:nextfile = substitute(l:file, '\v^(.*)'.l:curr.',.*', '\1'.(l:next).',*', '')
  if filereadable(l:nextfile)
    edit l:nextfile
  else
    echohl Error
    echom 'No slide: ' . l:nextfile
    echohl None
  endif
endfun

fun! LectureModeNext() abort
  call LectureModeSlide(1)
endfun

fun! LectureModePrev() abort
  call LectureModeSlide(-1)
endfun
