let s:source = {
      \ 'name': 'calc',
      \ 'kind': 'manual',
      \ 'min_pattern_length' : 3,
      \ 'is_volatile' : 1,
      \ 'mark' : '[calc]'
      \ }

function! s:source.get_complete_position(context)
  return necocalc#get_complete_position(a:context.input)
endfunction

function! s:source.gather_candidates(context)
  return necocalc#gather_candidates(a:context.complete_str)
endfunction

function! neocomplete#sources#calc#define()
  return s:source
endfunction

