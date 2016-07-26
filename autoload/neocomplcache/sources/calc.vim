let s:source = {
      \ 'name': '[calc]',
      \ 'kind': 'complfunc',
      \ }

function! s:source.initialize()
  call neocomplcache#set_completion_length('calc', 3)
endfunction

function! s:source.finalize()
endfunction

function! s:source.get_keyword_pos(cur_text)
  return necocalc#get_complete_position(a:cur_text)
endfunction

function! s:source.get_complete_words(cur_keyword_pos, cur_keyword_str)
  return necocalc#gather_candidates(cur_keyword_str)
endfunction

function! neocomplcache#sources#calc#define()
  return s:source
endfunction

