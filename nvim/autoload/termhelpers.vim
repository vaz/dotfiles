if !exists('g:terminal_ansi_colours')
  let g:terminal_ansi_colours = ['f0f0f0', 'd77c77', '82c78e', 'c1c782', '8fb2c8', 'bba7c6', '7bc3c4', 'e0e8f0', '6e6884', 'ff938d', 'a7fcb6', 'f7fda7', 'b6e3ff', 'f1d7ff', 'a0feff', 'ffffff']
end

fun! termhelpers#updateansi(...)
  if a:0 > 0
    let gb = a:1
  else
    let gb = 'g'
  endif
  for i in range(len(g:terminal_ansi_colours))
    exe 'let ' . gb .':terminal_color_' . i . ' = "#' . get(g:terminal_ansi_colours, i) . '"'
  endfor
endfun

fun! termhelpers#autoinsertmode()
  aug termhelpers
    au!
    au BufEnter term://* startinsert
  aug end
endfun
