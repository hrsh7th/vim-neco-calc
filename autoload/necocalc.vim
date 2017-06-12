function! necocalc#get_complete_position(input)
  return match(a:input,
        \'\(\d\+\(\.\d\+\)\=\|[\(]\)\(\d\+\(\.\d\+\)\=\|\s\|[()\+\-\*\/\%]\)\+$')
endfunction

function! necocalc#gather_candidates(complete_str)
  " trim.
  let l:cur_keyword_str = substitute(
        \ a:complete_str, '\s\+$', '', 'g')

  " doesn't process if digit only.
  if l:cur_keyword_str =~# '^\d\+\(\.\d\+\)\=$'
      return []
  endif

  " convert int to float.
  let l:code = substitute(l:cur_keyword_str,
        \'\(\d\+\(\.\d\+\)\=\)', 'str2float("\1")', 'g')

  " try calc.
  let l:keywords = []
  try
    let l:result = eval(l:code)
    call add(l:keywords, {
          \ 'word': substitute(l:cur_keyword_str. ' = '.
          \         printf('%g', l:result), '\.0\+$', '', 'g'),
          \ })
    call add(l:keywords, {
          \ 'word': substitute(printf('%g', l:result), '\.0\+$', '', 'g'),
          \ })
  catch
  endtry

  return l:keywords
endfunction

