set nocompatible              " be iMproved, required
filetype off                  " required
let mapleader=";"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Plug For Managing Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

"{{ The Basics }}
    Plug 'itchyny/lightline.vim'                                      " Lightline statusbar
"{{ File management }}
    Plug 'scrooloose/nerdtree'                                        " Nerdtree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'                    " Highlighting Nerdtree
    Plug 'ryanoasis/vim-devicons'                                     " Icons for Nerdtree
"{{ Productivity }}
    Plug 'vimwiki/vimwiki',                                           " VimWiki 
    "Plugin 'tpope/vim-fugitive'                                      " Github
"{{ Tim Pope Plugins }}
    "Plug 'tpope/vim-surround'                                        " Change surrounding marks
"{{ Syntax Highlighting and Colors }}
    Plug 'vim-python/python-syntax',        {'for': 'python'}         " Python highlighting
    Plug 'ap/vim-css-color'                                           " Color previews for CSS
"{{ Themes }}
    "Plug 'blackgate/tropikos-vim-theme'
    Plug 'joshdick/onedark.vim'
"{{ Programming Plugins }}
    
    "Tagbar
    Plug 'majutsushi/tagbar'
    
    "Python

    " Deoplete for auto commplete     
    Plug 'Shougo/deoplete.nvim',           {'for': ['python', 'kivy']}
    Plug 'deoplete-plugins/deoplete-jedi', {'for': 'python'}
    Plug 'roxma/nvim-yarp',                {'for': ['python', 'kivy']}
    Plug 'roxma/vim-hug-neovim-rpc',       {'for': ['python', 'kivy']}

    
call plug#end()


filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Python Plugins Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete settings
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
inoremap <expr> <c-n>  deoplete#manual_complete()

" Tab-complete, see https://goo.gl/LvwZZY
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searches current directory recursively
set path+=**                    
" Display all matches when tab complete
set wildmenu                    
set showtabline=2
" Highlight all searches
set hlsearch                    
" Incremental search
set incsearch                   
" Ignore case in search
set ignorecase                  
" Case sensitive if search includes Capital letter
set smartcase                   
" Needed to keep multiple buffers open
set hidden                      
" No auto backups
set nobackup                    
" No swap
set noswapfile                  
" Set if term supports 256 colors
set t_Co=256                     
" Display line numbers
set number relativenumber       
" Copy/paste between vim and other programs
set clipboard+=unnamedplus      
"" No shorcut should start with escape, it slows mode switching but disables arrow keys
"set noesckeys                  

" Esc was taking too much time to exit modes
set timeoutlen=1000              
set ttimeoutlen=5
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience
" Give more space for displaying messages
set updatetime=300              

set cmdheight=2                 
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved. Can be set to number also
set signcolumn=yes              

                                
set fileformat=unix
set encoding=utf-8
syntax on
let g:rehash256 = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Remap Keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap ESC to jk
inoremap jk <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The lightline.vim theme
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

" Always show statusline
set laststatus=2

" Uncomment to prevent non-normal modes showing in powerline and below powerline.
set noshowmode


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs.
set expandtab                   
" Be smart using tabs ;)
set smarttab                    
" One tab == four spaces.
set shiftwidth=4                
" One tab == four spaces.
set tabstop=4                   
" Round indent to a multiple of 'shiftwidth'
set shiftround                  
set autoindent

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
nnoremap <silent> <leader>k :NERDTreeToggle<CR>

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" toggle tagbar
nnoremap <silent> <leader>l :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Theming
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme onedark
let g:onedark_termcolors=256


" Uncomment one of the options below to highlight number of current line

set cursorline

" OPTION 1
" highlight clear CursorLine
" highlight CursorLineNR ctermbg=red 

" OPTION 2
hi CursorLineNr guifg=red
set cursorlineopt=number


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimWiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Open terminal inside Vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>tt :vnew term://bash<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mouse Scrolling
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=nicr
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Splits and Tabbed Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

" Removes pipes | that act as seperators on splits
set fillchars+=vert:\ 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => AutoComplete Pairs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"inoremap { {}<Esc>ha
"inoremap ( ()<Esc>ha
"inoremap [ []<Esc>ha
"inoremap " ""<Esc>ha
"inoremap ' ''<Esc>ha
"inoremap ` ``<Esc>ha

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Other Stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Python

let g:python_highlight_all = 1
