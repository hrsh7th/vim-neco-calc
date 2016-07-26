function! necocalc#get_complete_position(input)
  return match(a:input,
        \'\(\d\+\(\.\d\+\)\=\|[\(]\)\(\d\+\(\.\d\+\)\=\|\s\|[\(\)\+\-\*\/\%]\)\+$')
endfunction

function! necocalc#gather_candidates(complete_str)
  " trim.
  let cur_keyword_str = substitute(
        \ a:complete_str, '\s\+$', '', 'g')

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

