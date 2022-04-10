"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Uncomment to autostart the NERDTree
" autocmd vimenter * NERDTree
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=38

" toggle NERDTree
nnoremap <silent> <leader>l :NERDTreeToggle<CR>
" nnoremap <silent> <leader>j :NERDTreeFind<CR>

" toggle nerdtree on fileopen and focus editor not nerdtree
"autocmd VimEnter * NERDTreeFind
"autocmd VimEnter * wincmd p

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NerdTree Git Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
