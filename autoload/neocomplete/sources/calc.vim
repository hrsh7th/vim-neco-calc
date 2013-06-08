let s:source = {
      \ 'name': 'calc',
      \ 'kind': 'manual',
      \ 'min_pattern_length' : 3,
      \ 'is_volatile' : 1,
      \ 'mark' : '[calc]'
      \ }

function! s:source.get_complete_position(context)
  return match(a:context.input,
        \'\(\d\+\(\.\d\+\)\=\|[\(]\)\(\d\+\(\.\d\+\)\=\|\s\|[\(\)\+\-\*\/\%]\)\+$')
endfunction

function! s:source.gather_candidates(context)
  " trim.
  let cur_keyword_str = substitute(
        \ a:context.complete_str, '\s\+$', '', 'g')

  " doesn't process if digit only.
  if cur_keyword_str =~# '^\d\+\(\.\d\+\)\=$'
      return []
  endif

  " convert int to float.
  let code = substitute(cur_keyword_str,
        \'\(\d\+\(\.\d\+\)\=\)', 'str2float("\1")', 'g')

  " try calc.
  let keywords = []
  try
    let result = eval(code)
    call add(keywords, {
          \ 'word': substitute(cur_keyword_str. ' = '.
          \         printf('%g', result), '\.0\+$', '', 'g'),
          \ })
    call add(keywords, {
          \ 'word': substitute(printf('%g', result), '\.0\+$', '', 'g'),
          \ })
  catch
  endtry

  return keywords
endfunction

function! neocomplete#sources#calc#define()
  return s:source
endfunction

