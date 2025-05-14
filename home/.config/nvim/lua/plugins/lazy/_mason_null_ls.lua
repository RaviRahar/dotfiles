-------------------------------------------------------------------
-- => To automatically setup Lsps
-------------------------------------------------------------------
return {
    {
        "williamboman/mason.nvim",
        lazy = true,
        cmd = { "Mason", "MasonUpdate" },
        config = function()
            vim.cmd([[
                augroup MasonTheme
                    autocmd!

                    autocmd VimEnter * hi! MasonHeader cterm=bold gui=bold guifg=#000000 guibg=#83a598
                    autocmd VimEnter * hi! MasonHeaderSecondary cterm=bold gui=bold guifg=#000000 guibg=#83a598
                    autocmd VimEnter * hi! MasonHighlightBlock cterm=bold gui=bold guifg=#000000 guibg=#83a598
                    autocmd VimEnter * hi! MasonHighlightBlockBold cterm=bold gui=bold guifg=#000000 guibg=#83a598
                    autocmd VimEnter * hi! MasonHighlightBlockSecondary cterm=bold gui=bold guifg=#000000 guibg=#83a598
                    autocmd VimEnter * hi! MasonHighlightBlockBoldSecondary cterm=bold gui=bold guifg=#000000 guibg=#83a598
                augroup end
            ]])

            require("mason").setup({
                max_concurrent_installers = 4,
                registries = {
                    "github:mason-org/mason-registry",
                },
                ui = {
                    check_outdated_packages_on_open = true,
                    border = "rounded",
                    width = 0.85,
                    height = 0.70,
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        config = function()
            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup({
                automatic_enable = false,
                -- automatic_enable = {
                --     exclude = {
                --         "rust_analyzer",
                --     }
                -- },
                -- automatic_enable = {
                --     "lua_ls",
                -- },
                ensure_installed = {
                    -- "bashls",
                    -- "lua_ls",
                    -- "clangd",
                    -- "pyright",
                    -- "html",
                    -- "quick_lint_js",
                    -- "jsonls",
                    -- "tsserver",
                    -- "cmake",
                    -- "cssls",
                    -- "jdtls",
                    -- "rust_analyzer",
                    -- "kotlin_language_server",
                    -- "jedi_language_server",

                    -- "eslint_d",
                    -- "flake8",
                    -- "jsonlint",
                    -- "black",
                    -- "stylua",
                    -- "clang-format",
                    -- "prettierd",
                    -- "xmlformat",
                    -- "fixjson",
                },
            })
        end,
    },
    -------------------------------------------------------------------
    -- => Null Ls to automatically setup install formatters and linters
    -------------------------------------------------------------------
    {
        "nvimtools/none-ls.nvim",
        lazy = true,
        dependencies = {
            { "nvim-lua/plenary.nvim", lazy = true },
            {
                "jay-babu/mason-null-ls.nvim",
                lazy = true,
                config = function()
                    require("mason-null-ls").setup({
                        ensure_installed = {
                            -- "jsonlint",
                            -- "shellcheck",
                            -- "eslint_d",
                            -- "shellcheck",
                            -- "rustfmt",
                            -- "black",
                            -- "stylua",
                            -- "clang_format",
                            -- "prettierd",
                            -- "xmlformatter",
                            -- "fixjson",
                            -- "shfmt",
                        },
                    })
                end,
            },
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                border = "rounded",
                -- cmd = { "nvim" },
                -- debounce = 250,
                -- debug = false,
                -- default_timeout = 5000,
                -- diagnostic_config = nil,
                -- diagnostics_format = "#{m}",
                -- fallback_severity = vim.diagnostic.severity.ERROR,
                -- log_level = "warn",
                -- notify_format = "[null-ls] %s",
                -- on_attach = custom_attach,
                -- on_init = nil,
                -- on_exit = nil,
                -- root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
                -- should_attach = nil,
                -- sources = nil,
                -- temp_dir = nil,
                -- update_in_insert = false,
                sources = {
                    -- Important ones

                    -- null_ls.builtins.diagnostics.eslint_d,
                    -- null_ls.builtins.diagnostics.jsonlint,
                    -- null_ls.builtins.diagnostics.shellcheck,
                    -- null_ls.builtins.diagnostics.chktex,

                    -- null_ls.builtins.code_actions.eslint_d,
                    -- null_ls.builtins.code_actions.shellcheck,
                    -- null_ls.builtins.formatting.rustfmt,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.clang_format,
                    null_ls.builtins.formatting.prettierd,
                    -- null_ls.builtins.formatting.xmlformat,
                    -- null_ls.builtins.formatting.fixjson,
                    null_ls.builtins.formatting.shfmt.with({
                        args = { "-i", "2", "-ln", "bash", "-fn", "-ci", "-sr" },
                    }),
                    -- null_ls.builtins.formatting.latexindent,

                    -- null_ls.builtins.completion.spell,

                    -- null_ls.builtins.diagnostics.codespell,
                    -- null_ls.builtins.diagnostics.cpplint,
                    -- null_ls.builtins.diagnostics.flake8,
                    -- null_ls.builtins.diagnostics.markdownlint,
                    -- null_ls.builtins.diagnostics.yamllint,

                    -- null_ls.builtins.formatting.markdownlint,
                    -- null_ls.builtins.formatting.codespell,
                    -- null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
                    -- null_ls.builtins.formatting.clang_format.with({
                    --     extra_args = { "--style={ BasedOnStyle: InheritParentConfig } --fallback-style={ BasedOnStyle: Google }" },
                    -- }),
                    -- null_ls.builtins.formatting.yamlfmt,
                    -- null_ls.builtins.formatting.eslint_d,
                },
            })
        end,
    },
}
