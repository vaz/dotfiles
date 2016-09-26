let altbuf#loaded = 1

if exists("loaded_bufkill")
  let altbuf#flip = "BA"
  let altbuf#fallback = "BB"
else
  let altbuf#flip = "norm! \<c-^>"
  let altbuf#fallback = "bp"
endif

fun! altbuf#flip_if_listed()
  if buflisted(bufnr('#'))
    exe g:altbuf#flip
  else
    exe g:altbuf#fallback
  endif
endfun
