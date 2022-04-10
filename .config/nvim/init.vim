let mapleader=";"
syntax enable
filetype off                  
" required to ignore plugin indent changes, instead use
" filetype plugin on
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Plug For Managing Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

"{{ Statusline }}
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    "Plug 'itchyny/lightline.vim'                                      " Lightline statusbar
"{{ File management }}
    Plug 'scrooloose/nerdtree'                                        " Nerdtree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'                    " Highlighting Nerdtree
    Plug 'ryanoasis/vim-devicons'                                     " Icons for Nerdtree
    Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
    Plug 'junegunn/fzf.vim'
"{{ Productivity }}
    "Plug 'vimwiki/vimwiki',                                           " VimWiki 
"{{ Git Integration}}
    Plug 'Xuyuanp/nerdtree-git-plugin'                                " Shows Git Status in NerdTree
    Plug 'stsewd/fzf-checkout.vim'
    Plug 'tpope/vim-fugitive'                                         " Github
    Plug 'airblade/vim-gitgutter'                                     " Shows Git Gutter
"{{ Tim Pope Plugins }}
    "Plug 'tpope/vim-surround'                                        " Change surrounding marks
"{{ Syntax Highlighting and Colors }}
    "Plug 'sheerun/vim-polyglot'                                       " Syntax Highlighting for multiple languages
    Plug 'PotatoesMaster/i3-vim-syntax'                               " i3 config highlighting
    Plug 'vim-python/python-syntax'                                   " Python Highlighting
    Plug 'rust-lang/rust.vim'                                         " Rust syntax highlighting and more
    Plug 'HerringtonDarkholme/yats.vim'                               " TypeScript Syntax Highlighting
    Plug 'ap/vim-css-color'                                           " Color previews for CSS
"{{ Themes }}
    "Plug 'blackgate/tropikos-vim-theme'
    "Plug 'joshdick/onedark.vim'
    Plug 'morhetz/gruvbox'
"{{ Markdown Plugins  }}
    Plug 'junegunn/goyo.vim' 
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} 
"{{ Programming Plugins }} 
    Plug 'tmsvg/pear-tree'                                            " Automatic Pairing
    Plug 'majutsushi/tagbar'                                          " Tagbar
    Plug 'honza/vim-snippets'                                         " Snippets 
    Plug 'neoclide/coc.nvim', {'branch': 'release'}                   " AutoCompletition like VisualStudio
    
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General variables
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python_highlight_all = 1
let g:rustfmt_autosave = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searches current directory recursively
set path+=**                    
set guicursor=
set fileformat=unix
set encoding=utf-8
set wildmenu                    
set showtabline=2
set hlsearch                    
set incsearch                   
set ignorecase                  
set smartcase                   
set number relativenumber       
set hidden                      
set nobackup                    
set noswapfile                  
set clipboard=unnamedplus       
set termguicolors
set cursorline
" Can be set to 'yes'
set signcolumn=number
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50
" Esc was taking too much time to exit modes
set timeoutlen=1000              
set ttimeoutlen=5
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline related
" Always show tabs
set showtabline=2

" Always show statusline
set laststatus=2

" Uncomment to prevent non-normal modes showing in powerline and below powerline.
" We don't need to see things like -- INSERT -- anymore
set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, scroll, backspace, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set complete-=i
set scrolloff=8
set sidescrolloff=8
set display+=lastline

" Use spaces instead of tabs.
set expandtab                   
" Be smart using tabs ;)
set smarttab                    
" One tab == two spaces, default for all filetypes
set shiftwidth=2                
" One tab == two spaces, default for all filetypes
set tabstop=2                   
" Round indent to a multiple of 'shiftwidth'
set shiftround                  
set autoindent
set backspace=indent,eol,start
" Stops from automatically showing comment operator on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Set specific indentation for some filetypes
autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType rust setlocal shiftwidth=4 tabstop=4
autocmd FileType markdown setlocal shiftwidth=4 tabstop=4

" Keep cursor centered while n, N through searches
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Remap Keys and Some functionalities
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap ESC to jk
inoremap jk <Esc>
" Make Y(capital y) behave how C behaves
nnoremap Y y$
nnoremap <silent> <leader>qw :nohl<CR><leader>qw

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Open terminal inside Vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>tt :vnew term://bash<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mouse Scrolling
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=nicr
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Splits and Tabbed Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Removes pipes | that act as seperators on splits
set fillchars+=vert:\
set splitbelow splitright

" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" Change 2 split windows from vert to horiz or horiz to vert
map <leader>th <C-w>t<C-w>H
map <leader>tk <C-w>t<C-w>K

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Undo Breakpoints
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap , ,<c-g>U
inoremap . .<c-g>U
inoremap ! !<c-g>U
inoremap ? ?<c-g>U

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving Text
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
