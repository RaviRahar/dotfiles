"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Fugitive Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


nmap <leader>gs :G<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nnoremap <leader>gc :GCheckout<CR>
nnoremap <leader>ga :Git fetch --all<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim GitGutter Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set signcolumn=yes

"same as default
nmap ]h <Plug>(GitGutterNextHunk) 
"same as default
nmap [h <Plug>(GitGutterPrevHunk) 

nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)

let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '-'
let g:gitgutter_sign_modified_removed = '-'
