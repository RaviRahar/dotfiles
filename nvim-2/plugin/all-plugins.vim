"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => PearTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart pairs are disabled by default:
let g:pear_tree_map_special_keys = 0
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle tagbar
nnoremap <silent> <leader>' :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimWiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:vimwiki_list = [{'path': '~/vimwiki/',
"                      \ 'syntax': 'markdown', 'ext': '.md'}]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown-Previews
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Mappings
nmap <leader>md <Plug>MarkdownPreview
nmap <leader>ms <Plug>MarkdownPreviewStop
nmap <leader>mt <Plug>MarkdownPreviewToggle
