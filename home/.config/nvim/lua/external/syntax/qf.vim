if exists('b:current_syntax')
    finish
endif

syntax match qfFileName "^[^│]*" nextgroup=qfSeparatorLeft
syntax match qfSeparatorLeft "│" contained nextgroup=qfLineNr
syntax match qfLineNr "[^│]*" contained nextgroup=qfSeparatorRight
syntax match qfSeparatorRight "│" contained nextgroup=qfError,qfWarning,qfInfo,qfNote
syntax match qfError " E .*$" contained
syntax match qfWarning " W .*$" contained
syntax match qfInfo " I .*$" contained
syntax match qfNote " [NH] .*$" contained

hi def link qfFileName Directory
hi def link qfSeparatorLeft Delimiter
hi def link qfSeparatorRight Delimiter
hi def link qfLineNr LineNr
hi def link qfError DiagnosticError
hi def link qfWarning DiagnosticWarn
hi def link qfInfo DiagnosticInfo
hi def link qfNote DiagnosticHint


hi! def link QuickFixLine CursorLine

let b:current_syntax = 'qf'
