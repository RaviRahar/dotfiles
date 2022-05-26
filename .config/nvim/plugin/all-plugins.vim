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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File-Type Plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF

require("filetype").setup({
  overrides = {
    shebang = {
      -- Set the filetype of files with a dash shebang to sh
      dash = "sh",
    },
  },
})

EOF
