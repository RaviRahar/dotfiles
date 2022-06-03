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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6, 'relative': v:true, 'yoffset': 0.8 } }
let g:fzf_action = {'ctrl-s': 'split', 'ctrl-v': 'vsplit'}
let g:fzf_preview_window = ['right:50%:nowrap', 'ctrl-/']
"let g:fzf_preview_window = ['up:40%:hidden', 'right:50%', 'down:wrap', 'ctrl-/']
" files
let s:files_source = 'fd -HLp -t f -c never'
" Show hidden files
let $FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{*/node_modules/*,*/.git/*,*/package.json,*/package-lock.json,node_modules/*,.git/*,package.json,package-lock.json}"'
" let $FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{*/node_modules/*,*/.git/*,*/package.json,*/package-lock.json,node_modules/*,.git/*,package.json,package-lock.json}"'
let $FZF_DEFAULT_OPTS='--reverse'
" Search just inside files with :Rg and do not include file names
"command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" FZF shotcuts
nnoremap <silent> <Leader>fh :History<CR>
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fc :Colors<CR>
nnoremap <silent> <Leader>fr :Rg<CR>
nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>fs :History/<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>fw :Windows<CR>
nnoremap <silent> <Leader>fmh :Maps<CR>

" GIT FZF Shortcuts 
nnoremap <silent> <Leader>gf :GFiles<CR>
nnoremap <silent> <Leader>gbf :GFiles?<CR>
nnoremap <silent> <Leader>gl :Commits<CR>
nnoremap <silent> <Leader>gbl :BCommits<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Dashboard
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:dashboard_custom_header =[
    \'',
    \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡖⠁⠀⠀⠀⠀⠀⠀⠈⢲⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    \'⠀⠀⠀⠀⠀⠀⠀⠀⣼⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣧⠀⠀⠀⠀⠀⠀⠀⠀ ',
    \'⠀⠀⠀⠀⠀⠀⠀⣸⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣇⠀⠀⠀⠀⠀⠀⠀ ',
    \'⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⢀⣀⣤⣤⣤⣤⣀⡀⠀⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀ ',
    \'⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣔⢿⡿⠟⠛⠛⠻⢿⡿⣢⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀ ',
    \'⠀⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣷⣤⣀⡀⢀⣀⣤⣾⣿⣿⣿⣷⣶⣤⡀⠀⠀⠀⠀ ',
    \'⠀⠀⢠⣾⣿⡿⠿⠿⠿⣿⣿⣿⣿⡿⠏⠻⢿⣿⣿⣿⣿⠿⠿⠿⢿⣿⣷⡀⠀⠀ ',
    \'⠀⢠⡿⠋⠁⠀⠀⢸⣿⡇⠉⠻⣿⠇⠀⠀⠸⣿⡿⠋⢰⣿⡇⠀⠀⠈⠙⢿⡄⠀ ',
    \'⠀⡿⠁⠀⠀⠀⠀⠘⣿⣷⡀⠀⠰⣿⣶⣶⣿⡎⠀⢀⣾⣿⠇⠀⠀⠀⠀⠈⢿⠀ ',
    \'⠀⡇⠀⠀⠀⠀⠀⠀⠹⣿⣷⣄⠀⣿⣿⣿⣿⠀⣠⣾⣿⠏⠀⠀⠀⠀⠀⠀⢸⠀ ',
    \'⠀⠁⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⢇⣿⣿⣿⣿⡸⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠈⠀ ',
    \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    \'⠀⠀⠀⠐⢤⣀⣀⢀⣀⣠⣴⣿⣿⠿⠋⠙⠿⣿⣿⣦⣄⣀⠀⠀⣀⡠⠂⠀⠀⠀ ',
    \'⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠉⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠋⠁⠀⠀⠀⠀⠀ ',
    \'',
    \]


let g:dashboard_default_executive ='fzf'
nmap <Leader>ds :<C-u>SessionSave<CR>
nmap <Leader>dl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fn :DashboardNewFile<CR>

let g:dashboard_custom_shortcut={
\ 'last_session'       : '<leader> d l',
\ 'find_history'       : '<leader> f h',
\ 'find_file'          : '<leader> f f',
\ 'change_colorscheme' : '<leader> f c',
\ 'find_word'          : '<leader> f r',
\ 'book_marks'         : '<leader> f m',
\ 'new_file'           : '<leader> f n',
\ }

let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

nnoremap <S-h> :call ToggleHiddenAll()<CR>

let g:indentLine_fileTypeExclude = ['dashboard']
autocmd FileType dashboard call ToggleHiddenAll() | autocmd WinLeave <buffer> call ToggleHiddenAll()
