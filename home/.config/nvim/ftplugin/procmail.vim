" Vim filetype plugin file
" Language:             procmail(1) configuration file
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2008-07-09

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let b:undo_ftplugin = "setl com< cms< inc< fo<"

setlocal comments=:# commentstring=#\ %s formatoptions-=t formatoptions+=1ql

let &l:include = '^\s*INCLUDERC\>'

let &cpo = s:cpo_save
unlet s:cpo_save
