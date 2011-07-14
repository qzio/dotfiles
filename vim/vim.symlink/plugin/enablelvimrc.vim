if exists("g:loaded_enablevimrc") || &cp
  echo "ENABLEVIMRC ALREADY EXISTS"
  finish
endif
let g:loaded_enablevimrc= 1
let s:cpo_save = &cpo
set cpo&vim

" enable support for .lvimrc
function! Enablelvimrc()
  if filereadable(".lvimrc")
    so .lvimrc
  endif
endfunction
:call Enablelvimrc()
let &cpo = s:cpo_save
