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
  return match(a:cur_text, '\(\d\+\(\.\d\+\)\=\|[\(]\)\(\d\+\(\.\d\+\)\=\|\s\|[\(\)\+\-\*\/\%]\)\+$')
endfunction

function! s:source.get_complete_words(cur_keyword_pos, cur_keyword_str)
  " trim.
  let cur_keyword_str = substitute(a:cur_keyword_str, '\s\+$', '', 'g')

  " doesn't process if digit only.
  if cur_keyword_str =~# '^\d\+\(\.\d\+\)\=$'
      return []
  endif

  " convert int to float.
  let code = substitute(cur_keyword_str, '\(\d\+\(\.\d\+\)\=\)', 'str2float("\1")', 'g')

  " try calc.
  let keywords = []
  try
    let result = eval(code)
    call add(keywords, {'word': substitute(cur_keyword_str. ' = '. printf('%g', result), '\.0\+$', '', 'g'), 'menu': 'calc'})
    call add(keywords, {'word': substitute(printf('%g', result), '\.0\+$', '', 'g'), 'menu': 'calc'})
  catch
  endtry

  return keywords
endfunction

function! neocomplcache#sources#calc#define()
  return s:source
endfunction

