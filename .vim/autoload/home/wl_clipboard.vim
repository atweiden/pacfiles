vim9script

# Credit: https://github.com/habamax/.vim
export def WLPaste(cmd: string): void
  setreg("@", system('wl-paste --no-newline')->substitute('', '', 'g'))
  execute 'normal! ""' .. cmd
enddef

export def WLYank(event: dict<any>): void
  if event.regname =~ '+' || &clipboard =~ '\<unnamed\(plus\)\?\>'
    system('wl-copy', getreg("@"))
  endif
enddef

# vim: set filetype=vim foldmethod=marker foldlevel=0 nowrap:
