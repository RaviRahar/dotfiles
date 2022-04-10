"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle tagbar
nnoremap <silent> <leader>' :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimtex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:vimtex_view_method = 'firefox'
let g:vimtex_view_general_viewer = 'firefox'
let g:vimtex_view_general_options = 'file:@pdf\#src:@line@tex'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => PearTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart pairs are disabled by default:
let g:pear_tree_map_special_keys = 0
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown-Previews
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Mappings
nmap <leader>md <Plug>MarkdownPreview
nmap <leader>ms <Plug>MarkdownPreviewStop
nmap <leader>mt <Plug>MarkdownPreviewToggle

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neoformat: autoformat on save
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"augroup fmt
"  autocmd!
"  autocmd BufWritePre * undojoin | Neoformat
"augroup END

" Downside: Must hit enter when file is changed outside of vim and you; Select "y" to overwrite it and Neoformat is run after that
augroup fmt
  autocmd!
  au BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup END


" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
"let g:neoformat_run_all_formatters = 1

let g:neoformat_only_msg_on_error = 1
