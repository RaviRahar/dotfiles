local packer = {}
local packer_bootstrap

function packer:packer_load_plugins()
    return require("packer").startup(function(use)
        -- {{ Packer }}
        use("wbthomason/packer.nvim")

        -- {{ Basics }}
        use("lewis6991/impatient.nvim")
        use("nvim-lua/plenary.nvim")
        -- {{ Tim Pope Plugins }}
        use("tpope/vim-surround")
        use("tpope/vim-commentary")

        use({
            "goolord/alpha-nvim",
            opt = true,
            event = "BufWinEnter",
            config = "require('plugins._alpha')",
        })
        use({
            "williamboman/mason.nvim",
            opt = true,
            cmd = { "Mason*" },
            config = "require('plugins._mason')",
        })
        use({ "williamboman/mason-lspconfig.nvim", opt = true })

        -- {{ Statusline }}
        use({
            "nvim-lualine/lualine.nvim",
            opt = true,
            event = "BufWinEnter",
            config = "require('plugins._lualine')",
            requires = { { "kyazdani42/nvim-web-devicons" }, { "arkav/lualine-lsp-progress" }, opt = true },
        })

        -- {{ Autocompletion }}
        use({
            "neovim/nvim-lspconfig",
            opt = true,
            event = "BufEnter",
            config = "require('plugins._lspconfig')",
        })
        use({
            "hrsh7th/nvim-cmp",
            event = "BufEnter",
            config = "require('plugins._cmp')",
            requires = {
                { "onsails/lspkind-nvim" },
                { "lukas-reineke/cmp-under-comparator" },
                --   Autocompletion sources
                {
                    "L3MON4D3/LuaSnip",
                    opt = true,
                    after = "nvim-cmp",
                    module = "luasnip",
                    requires = { "rafamadriz/friendly-snippets", opt = true },
                },
                { "saadparwaiz1/cmp_luasnip", opt = true, after = "LuaSnip" },
                { "hrsh7th/cmp-nvim-lsp", opt = true, after = "cmp_luasnip" },
                { "hrsh7th/cmp-nvim-lsp-signature-help", opt = true, after = "cmp-nvim-lsp" },
                { "hrsh7th/cmp-nvim-lua", opt = true, after = "cmp-nvim-lsp-signature-help" },
                { "hrsh7th/cmp-path", opt = true, after = "cmp-nvim-lua" },
                { "hrsh7th/cmp-buffer", opt = true, after = "cmp-path" },
                { "lukas-reineke/cmp-rg", opt = true, after = "cmp-buffer" },
                { "hrsh7th/cmp-calc", opt = true, after = "cmp-rg" },
                { "octaltree/cmp-look", opt = true, after = "cmp-calc" },
                { "kdheepak/cmp-latex-symbols", opt = true, after = "cmp-look" },
                {
                    "saecki/crates.nvim",
                    opt = true,
                    event = { "BufRead Cargo.toml" },
                    config = function()
                        require("crates").setup()
                    end,
                },

                {
                    "David-Kunz/cmp-npm",
                    event = "BufRead package.json, package-lock.json",
                    config = function()
                        require("cmp-npm").setup()
                    end,
                },
            },
        })

        use({
            "pedro757/emmet",
            opt = true,
            ft = { "html", "css", "xml", "sass", "javascript", "typescript", "javascriptreact", "typescriptreact" },
            config = "require('plugins.lang-spec')",
        })

        -- {{ Language specific: autocompletion }}
        use({
            "simrat39/rust-tools.nvim",
            opt = true,
            ft = "rust",
            config = "require('plugins.lang-spec')",
        })
        use({
            "akinsho/flutter-tools.nvim",
            opt = true,
            ft = "dart",
            config = "require('plugins.lang-spec')",
        })
        use({
            "p00f/clangd_extensions.nvim",
            opt = true,
            ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            config = "require('plugins.lang-spec')",
        })
        -- use { 'mfussenegger/nvim-jdtls',
        --     opt = true,
        --     ft = "java",
        --     config = "require('plugins.lang-spec')",
        -- }

        -- {{ Language specific plugins }}
        use({ "rust-lang/rust.vim", opt = true, ft = "rust" })
        use({ "udalov/kotlin-vim", opt = true, ft = "kotlin" })

        -- {{ Tree-sitter: syntax highlighting }}
        use({
            "nvim-treesitter/nvim-treesitter",
            opt = true,
            run = ":TSUpdate",
            event = "BufEnter",
            config = "require('plugins._treesitter')",
        })

        use({
            "jose-elias-alvarez/null-ls.nvim",
            opt = true,
            after = "nvim-lspconfig",
            config = "require('plugins._null-ls')",
        })
        use({
            "stevearc/dressing.nvim",
            opt = true,
            after = "nvim-lspconfig",
        })
        -- {{ Dap and debug }}
        use({
            "rcarriga/nvim-dap-ui",
            opt = false,
            config = "require('plugins._dap')",
            requires = {
                { "mfussenegger/nvim-dap" },
                {
                    "Pocco81/dap-buddy.nvim",
                    opt = true,
                    cmd = { "DIInstall", "DIUninstall", "DIList" },
                },
            },
        })
        use({
            "folke/trouble.nvim",
            opt = true,
            cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
            config = "require('plugins._trouble')",
        })
        use({
            "michaelb/sniprun",
            opt = true,
            run = "bash ./install.sh",
            cmd = { "SnipRun", [['<,'>SnipRun]], "SnipRun*" },
            config = "require('plugins._sniprun')",
        })
        use({ "preservim/tagbar", opt = true, cmd = "TagbarToggle" })

        -- {{ Fzf and Telescope }}
        use({
            "ibhagwan/fzf-lua",
            -- optional for icon support
            opt = true,
            cmd = { "FzfLua*" },
            module = "fzf-lua",
            config = "require('plugins._fzf')",
            requires = {
                { "kyazdani42/nvim-web-devicons" },
                {
                    "junegunn/fzf",
                    run = function()
                        vim.fn["fzf#install"]()
                    end,
                },
            },
        })
        use({
            "nvim-telescope/telescope.nvim",
            opt = true,
            module = "telescope",
            cmd = "Telescope*",
            config = "require('plugins._telescope')",
            requires = {
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    opt = true,
                    run = "make",
                },
                {
                    "nvim-telescope/telescope-project.nvim",
                    opt = true,
                    after = "telescope-fzf-native.nvim",
                },
                {
                    "nvim-telescope/telescope-frecency.nvim",
                    opt = true,
                    after = "telescope-project.nvim",
                    requires = { { "tami5/sqlite.lua", opt = true } },
                },
            },
        })
        -- {{ Git }}
        use({
            "lewis6991/gitsigns.nvim",
            opt = true,
            event = { "BufRead", "BufNewFile" },
            config = "require('plugins._gitsigns')",
        })
        use({
            "tpope/vim-fugitive",
            -- opt = true,
            -- cmd = { "Git *", "G" },
        })

        -- {{ Themes }}
        use({
            "ellisonleao/gruvbox.nvim",
            config = "require('plugins._gruvbox')",
        })
        use("ap/vim-css-color")

        -- {{ Markdown and Latex plugins  }}
        use({
            "folke/zen-mode.nvim",
            config = function()
                require("zen-mode").setup({
                    window = { backdrop = 1, width = 100, options = { number = false, relativenumber = false } },
                })
            end,
        })
        use({
            "ellisonleao/glow.nvim",
            opt = true,
            branch = "main",
            ft = "markdown",
            config = function()
                require("glow").setup({
                    border = "rounded",
                    -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                })
            end,
        })
        use({
            "iamcco/markdown-preview.nvim",
            opt = true,
            run = function()
                vim.fn["mkdp#util#install"]()
            end,
            setup = function()
                vim.g.mkdp_filetypes = { "markdown" }
            end,
            ft = { "markdown" },
        })
        -- use { 'lervag/vimtex',
        --     opt = true,
        --     ft = "latex",
        --     config = "require('plugins._vimtex')",
        -- }

        if packer_bootstrap then
            require("packer").sync()
        end
    end)
end

function packer:packer_check()
    local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        packer_bootstrap = vim.fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
    end

    vim.o.runtimepath = vim.fn.stdpath("data") .. "/site/pack/*/start/*," .. vim.o.runtimepath

    require("packer").init({
        compile_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "packer", "packer_compiled.vim"),
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "rounded" })
            end,
        },
        profile = {
            enable = false,
            threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
        },
    })
end

function packer:packer_autocompile()
    vim.cmd([[
        augroup PackerAutoCompile
          autocmd!
          autocmd BufWritePost packer.lua source <afile> | PackerCompile
        augroup end
    ]])
end

function packer:packer_include_compiled()
    vim.api.nvim_exec([[runtime! packer/packer_compiled.vim]], false)
end

local function load_plugins()
    packer:packer_check()
    if packer_bootstrap then
        packer:packer_load_plugins()
        return
    end
    require("impatient").enable_profile()
    require("plugins.keybindings")
    packer:packer_load_plugins()
    packer:packer_autocompile()
    packer:packer_include_compiled()
end

load_plugins()
