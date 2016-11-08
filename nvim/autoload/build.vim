
fun! build#node_host(info) abort
  if a:info.status != 'unchanged' || a:info.force
    !npm install
    UpdateRemotePlugins
  endif
endfun

fun! build#jscc(info) abort
  if a:info.status != 'unchanged' || a:info.force
    !npm install --update && (cd rplugin/node; npm install --update)
    UpdateRemotePlugins
  endif
endfun
