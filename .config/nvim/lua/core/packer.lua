local packer = {}
local is_packer_installed

function packer:packer_load_plugins()
  return require('packer').startup(
    function(use)

      -- {{ Packer }}
      use 'wbthomason/packer.nvim'

      -- {{ Basics }}
      use 'lewis6991/impatient.nvim'
      use 'nathom/filetype.nvim'
      use 'glepnir/dashboard-nvim'
      use 'nvim-lua/plenary.nvim'

      -- {{ Statusline }}
      use { 'nvim-lualine/lualine.nvim',
        requires = { { 'kyazdani42/nvim-web-devicons', 'arkav/lualine-lsp-progress' }, opt = true }
      }

      -- {{ Nvim-cmp: autocompletion }}
      --   LSP Installer
      use 'williamboman/nvim-lsp-installer'

      use 'neovim/nvim-lspconfig'
      use 'hrsh7th/nvim-cmp'
      use 'onsails/lspkind-nvim'
      --  Formatting etc. plugins for autocompletion
      use 'hrsh7th/cmp-nvim-lsp-signature-help'
      use 'lukas-reineke/cmp-under-comparator'
      --   Autocompletion sources
      use 'hrsh7th/cmp-nvim-lsp'
      use 'hrsh7th/cmp-nvim-lua'
      use 'hrsh7th/cmp-buffer'
      use 'hrsh7th/cmp-path'
      use 'hrsh7th/cmp-cmdline'
      use 'hrsh7th/cmp-calc'
      use 'lukas-reineke/cmp-rg'
      use 'octaltree/cmp-look'
      use 'kdheepak/cmp-latex-symbols'
      use { 'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        config = function() require('crates').setup() end,
      }

      use { 'David-Kunz/cmp-npm',
        event = "BufRead package.json, package-lock.json",
        config = function() require('cmp-npm').setup() end,
      }
      use 'pedro757/emmet'

      --   Snippets
      use 'L3MON4D3/LuaSnip'
      use 'saadparwaiz1/cmp_luasnip'
      use 'rafamadriz/friendly-snippets'

      -- {{ Language specific: autocompletion }}
      use 'p00f/clangd_extensions.nvim'
      use 'akinsho/flutter-tools.nvim'
      use 'simrat39/rust-tools.nvim'
      --use 'mfussenegger/nvim-jdtls'

      -- {{ Tree-sitter: syntax highlighting }}
      use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = { { 'p00f/nvim-ts-rainbow' } },
      }
      --use 'udalov/kotlin-vim'

      -- {{ Dap and debug }}
      use 'mfussenegger/nvim-dap'
      use 'Pocco81/dap-buddy.nvim'
      use 'rcarriga/nvim-dap-ui'
      use 'folke/trouble.nvim'
      use { 'michaelb/sniprun', run = 'bash ./install.sh' }

      -- {{ Telescope }}
      use 'nvim-telescope/telescope.nvim'

      -- {{ Git }}
      use 'tpope/vim-fugitive'
      use 'lewis6991/gitsigns.nvim'

      -- {{ Tim Pope Plugins }}
      use 'tpope/vim-surround'
      -- {{ Tagbar: to show classes etc. }}
      use 'majutsushi/tagbar'
      -- {{ OrgMode }}
      use { 'nvim-orgmode/orgmode', config = function()
        require('orgmode').setup {}
      end }
      -- {{ Themes }}
      use "ellisonleao/gruvbox.nvim"
      use 'ap/vim-css-color'

      -- {{ Markdown and Latex plugins  }}
      use { 'folke/zen-mode.nvim', config = function()
        require('zen-mode').setup {
          window = { backdrop = 1, width = 100, options = { number = false, relativenumber = false } }
        }
      end }
      use { "ellisonleao/glow.nvim", branch = 'main' }
      use { "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = "markdown",
      }
      --use 'lervag/vimtex'

      -- {{ Language specific plugins }}
      use 'rust-lang/rust.vim'

      if is_packer_installed then
        require('packer').sync()
      end
    end)
end

function packer:packer_configure_plugins()
  local ok, _ = pcall(require, 'plugins')
end

function packer:packer_check()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_packer_installed = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  end
end

function packer:packer_autocompile()

  vim.api.nvim_exec([[
  augroup PackerAutoCompile
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerCompile
  augroup end
  ]], false)

end

packer:packer_check()
packer:packer_load_plugins()
packer:packer_autocompile()
packer:packer_configure_plugins()

return packer
