function! Indent(ignore)
  execute "normal v" . v:count1 . ">\<ESC>"
endfunction

" vim: set filetype=vim foldmethod=marker foldlevel=0 nowrap:
