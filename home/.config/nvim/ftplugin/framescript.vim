" Vim ftplugin file
" Language:             FrameScript
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2008-07-19

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let b:undo_ftplugin = "setl com< cms< fo< inc< | unlet! b:matchwords"

setlocal comments=s1:/*,mb:*,ex:*/,:// commentstring=/*\ %s\ */
setlocal formatoptions-=t formatoptions+=1ql
setlocal include=^\\s*<#Include

if exists("loaded_matchit")
  let s:not_end = '\c\%(\<End\)\@<!'
  let b:match_words =
        \ s:not_end . '\<If\>:\c\<ElseIf\>:\c\<Else\>:\c\<EndIf\>,' .
        \ s:not_end . '\<Loop\>:\c\<EndLoop\>' .
        \ s:not_end . '\<Sub\>:\c\<EndSub\>'
  unlet s:not_end
endif

let &cpo = s:cpo_save 
unlet s:cpo_save
