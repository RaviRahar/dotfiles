let mapleader=";"
syntax enable
filetype off
" required to ignore plugin indent changes, instead use
" filetype plugin on
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Plug For Managing Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

"{{ Basics }}
    Plug 'nathom/filetype.nvim'
    Plug 'glepnir/dashboard-nvim'
    Plug 'nvim-lua/plenary.nvim'
"{{ Statusline }}
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
"{{ Nvim-cmp: autocompletion }} 
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'onsails/lspkind-nvim'
""  Formatting etc. plugins for autocompletion
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'lukas-reineke/cmp-under-comparator'
""   Autocompletion sources
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-calc'
    Plug 'lukas-reineke/cmp-rg'
    Plug 'octaltree/cmp-look'
    Plug 'kdheepak/cmp-latex-symbols'
    Plug 'saecki/crates.nvim'
    Plug 'David-Kunz/cmp-npm'
    Plug 'pedro757/emmet'
""   Snippets
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'rafamadriz/friendly-snippets'
"{{ Language specific: autocompletion }} 
    Plug 'p00f/clangd_extensions.nvim'
    Plug 'akinsho/flutter-tools.nvim'
    Plug 'simrat39/rust-tools.nvim'
    "Plug 'mfussenegger/nvim-jdtls'
"{{ Tree-sitter: syntax highlighting }}
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'p00f/nvim-ts-rainbow' 
    "Plug 'udalov/kotlin-vim' 
"{{ Dap and debug }}
    Plug 'mfussenegger/nvim-dap'
    Plug 'Pocco81/dap-buddy.nvim'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'folke/trouble.nvim'
    Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
"{{ Fzf }} 
    Plug 'junegunn/fzf', {'do': ':call fzf#install()'}
    Plug 'junegunn/fzf.vim'
"{{ Git }}
    Plug 'tpope/vim-fugitive'                                         
    Plug 'airblade/vim-gitgutter'
    Plug 'stsewd/fzf-checkout.vim'
"{{ Tim Pope Plugins }}
    Plug 'tpope/vim-surround'                                       
"{{ Tagbar: to show classes etc. }}
    Plug 'majutsushi/tagbar'                                         
"{{ OrgMode }}
    Plug 'nvim-orgmode/orgmode'
"{{ PearTree: Automatic pairing of brackets etc. }}
    Plug 'tmsvg/pear-tree'                                           
"{{ Themes }}
    Plug 'morhetz/gruvbox'
    Plug 'ap/vim-css-color'                                      
"{{ Markdown and Latex Plugins  }}
    Plug 'junegunn/goyo.vim' 
    Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' } 
    Plug 'lervag/vimtex'
"{{ Language specific plugins }} 
    Plug 'rust-lang/rust.vim'                                       
""{{ Jupyter Notebook }} 
"    Plug 'ahmedkhalf/jupyter-nvim', { 'do': ':UpdateRemotePlugins' }

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
set showtabline=2
set hlsearch                    
set incsearch                   
set ignorecase                  
set smartcase                   
set number relativenumber       
set hidden                      
set nobackup                    
set noswapfile                  
set autochdir
set clipboard=unnamedplus       
" Increment/Dec alphabets too with (g) Ctrl-a/Ctrl-x
set nrformats+=alpha
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
" Transparent pop menu
set pumblend=15
hi PmenuSel gui=None cterm=None blend=0

if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

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
" => Wildmenu to traverse files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nice menu when typing `:find *.py`
"set wildmode=longest,list,full
set wildmenu                    
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Wildmenu to traverse files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_altv = 1
let g:netrw_alto = 1
let g:netrw_liststyle = 3
let g:netrw_preview = 1
"let g:netrw_keepdir= 0
let g:netrw_errorlvl = 2
"open files in: 1 horizontal split, 2 vertical split, 3 new tab, 4 previous window
let g:netrw_browse_split = 3

let ghregex='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide=ghregex

nnoremap <silent> <leader>l :Lexplore<CR>

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    nnoremap <buffer> <C-h> <C-w>h
    nnoremap <buffer> <C-j> <C-w>j
    nnoremap <buffer> <C-k> <C-w>k
    nnoremap <buffer> <C-l> <C-w>l
endfunction

" close netrw buffer
autocmd FileType netrw setl bufhidden=wipe

" close if final buffer is netrw or the quickfix
augroup finalcountdown
 au!
 autocmd BufEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
augroup END

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
nnoremap <silent> <leader>qw :nohl<CR>
inoremap <C-e> <C-o>A
inoremap <C-a> <C-o>_

" tabs
nnoremap <silent> <leader>to :tabonly<CR>
" windows (splits)
nnoremap <silent> <leader>bo :only<CR>
" buffer
nnoremap <silent> <leader>bn :bn<CR>
nnoremap <silent> <leader>bp :bp<CR>
nnoremap <silent> <leader>bd :bd<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Open terminal inside Vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <lader>tt :vnew term://bash<CR>
nnoremap <silent> <leader>tt :! alacritty --config-file $HOME/.config/alacritty/floating.yml --working-directory %:p:h<CR>

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
map <leader>tv <C-w>t<C-w>K

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
nnoremap <leader>k :m .-2<CR>==e
