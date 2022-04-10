"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }
" Show hidden files
let $FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{*/node_modules/*,*/.git/*,*/package.json,*/package-lock.json,node_modules/*,.git/*,package.json,package-lock.json}"'
let $FZF_DEFAULT_OPTS='--reverse'
" Search for file names
nnoremap <silent> <leader>f :Files<CR>
" Search Inside Files
nnoremap <silent> <C-f> :Rg<CR>
" Search just inside files with :Rg and do not include file names
"command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
