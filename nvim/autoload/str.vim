" TODO: better arg specs

" Function: str#ltrim(s, [pattern='\s*'])
fun! str#ltrim(s, ...) abort
  let pat = get(a:000, 1, '\s*')
  return substitute(a:s, '^'.get(a:000, 1, '\s*'), '', '')
endfun

" Function: str#rtrim(s, [pattern='\s*'])
fun! str#rtrim(s, ...) abort
  return substitute(a:s, get(a:000, 1, '\s*').'$', '', '')
endfun

" Function: str#trim(s, [pattern='\s*'])
fun! str#trim(s, ...) abort
  let pat = get(a:000, 1, '\s*')
  return Ltrim(Rtrim(a:s, pat), pat)
endfun

" Function: str#isblank(s)
fun! str#isblank(s) abort
  return !len(Trim(''.a:s))
endfun
