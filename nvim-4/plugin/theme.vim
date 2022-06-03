"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Theming
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GruvBox Settings
set background=dark
"let g:airline_powerline_fonts = 1
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_transparent_bg = 1
let g:gruvbox_termcolors=256
let g:rehash256 = 1
colorscheme gruvbox
" Needed to set terminal transparency and blur
autocmd VimEnter * hi Normal ctermbg=none guibg=none
autocmd VimEnter * hi LineNr ctermbg=none guibg=none
autocmd VimEnter * hi SignColumn ctermbg=none guibg=none
autocmd VimEnter * hi CursorLine ctermbg=none guibg=none
