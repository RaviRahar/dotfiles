-------------------------------------------------------------------
-- => To automatically setup Lsps
-------------------------------------------------------------------
return {
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        config = function()
            local nvim_lsp = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local mason_lspconfig = require("mason-lspconfig")

            mason_lspconfig.setup({
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

            --------------------------------------------------------------
            -- => Server-Configs
            ---------------------------------------------------------------
            mason_lspconfig.setup_handlers({
                function(server_name)
                    nvim_lsp[server_name].setup({
                        capabilities = capabilities,
                        flags = { debounce_text_changes = 150 },
                    })
                end,
                ["jdtls"] = function()
                    -- do nothing as nvim-jdtls will set it up
                end,
                ["rust_analyzer"] = function()
                    nvim_lsp.rust_analyzer.setup({
                        standalone = true,
                        cmd = { "rust-analyzer" },
                        capabilities = capabilities,
                        flags = {
                            debounce_text_changes = 150,
                        }
                    })
                end,
                ["gopls"] = function()
                    nvim_lsp.gopls.setup({
                        flags = { debounce_text_changes = 500 },
                        capabilities = capabilities,
                        cmd = { "gopls", "-remote=auto" },
                        settings = {
                            gopls = {
                                usePlaceholders = true,
                                analyses = {
                                    nilness = true,
                                    shadow = true,
                                    unusedparams = true,
                                    unusewrites = true,
                                },
                            },
                        },
                    })
                end,
                ["kotlin_language_server"] = function()
                    nvim_lsp.kotlin_language_server.setup({
                        capabilities = capabilities,
                        flags = { debounce_text_changes = 150 },
                        settings = {
                            kotlin = {
                                debounceTime = 150,
                                linting = { debounceTime = 150 },
                                indexing = { enabled = false },
                                debugAdapter = { enabled = false },
                                completion = { snippets = { enabled = true } },
                            },
                        },
                    })
                end,
                ["hls"] = function()
                    nvim_lsp.hls.setup({
                        single_file_support = true,
                        capabilities = capabilities,
                        flags = { debounce_text_changes = 150 },
                        filetypes = { 'haskell', 'lhaskell', 'cabal' },
                        cmd = { 'haskell-language-server-wrapper', '--lsp' },
                        root_dir = function(filepath)
                            return (
                                nvim_lsp.util.root_pattern('hie.yaml', 'stack.yaml', 'cabal.project')(filepath)
                                or nvim_lsp.util.root_pattern('*.cabal', 'package.yaml')(filepath)
                            -- or nvim_lsp.util.find_git_ancestor(filepath)
                            )
                        end,
                        settings = {
                            haskell = {
                                cabalFormattingProvider = "cabalfmt",
                                formattingProvider = "ormolu"
                            }
                        },
                    })
                end,
                ["ltex"] = function()
                    nvim_lsp.kotlin_language_server.setup({
                        settings = {
                            ltex = {
                                enabled = {
                                    "bibtex",
                                    "gitcommit",
                                    "markdown",
                                    "org",
                                    "tex",
                                    "restructuredtext",
                                    "rsweave",
                                    "latex",
                                    "quarto",
                                    "rmd",
                                    "context",
                                    "html",
                                    "xhtml",
                                    "mail",
                                }
                            },
                        },
                    })
                end,
                ["lua_ls"] = function()
                    nvim_lsp.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        ["/usr/share/awesome/lib/"] = true,
                                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                                    },
                                    maxPreload = 100000,
                                    preloadFileSize = 10000,
                                },
                                completion = {
                                    enable = true,
                                },
                                diagnostics = {
                                    enable = true,
                                    globals = { "vim", "awesome", "client", "mouse", "root", "screen" },
                                },
                                telemetry = {
                                    enable = false,
                                },
                            },
                        },
                    })
                end,
                ["jsonls"] = function()
                    nvim_lsp.jsonls.setup({
                        flags = { debounce_text_changes = 500 },
                        capabilities = capabilities,
                        settings = {
                            json = {
                                -- Schemas https://www.schemastore.org
                                schemas = {
                                    {
                                        fileMatch = { "package.json" },
                                        url = "https://json.schemastore.org/package.json",
                                    },
                                    {
                                        fileMatch = { "tsconfig*.json" },
                                        url = "https://json.schemastore.org/tsconfig.json",
                                    },
                                    {
                                        fileMatch = {
                                            ".prettierrc",
                                            ".prettierrc.json",
                                            "prettier.config.json",
                                        },
                                        url = "https://json.schemastore.org/prettierrc.json",
                                    },
                                    {
                                        fileMatch = { ".eslintrc", ".eslintrc.json" },
                                        url = "https://json.schemastore.org/eslintrc.json",
                                    },
                                    {
                                        fileMatch = {
                                            ".babelrc",
                                            ".babelrc.json",
                                            "babel.config.json",
                                        },
                                        url = "https://json.schemastore.org/babelrc.json",
                                    },
                                    {
                                        fileMatch = { "lerna.json" },
                                        url = "https://json.schemastore.org/lerna.json",
                                    },
                                    {
                                        fileMatch = {
                                            ".stylelintrc",
                                            ".stylelintrc.json",
                                            "stylelint.config.json",
                                        },
                                        url = "http://json.schemastore.org/stylelintrc.json",
                                    },
                                    {
                                        fileMatch = { "/.github/workflows/*" },
                                        url = "https://json.schemastore.org/github-workflow.json",
                                    },
                                },
                            },
                        },
                    })
                end,
                ["clangd"] = function()
                    vim.api.nvim_create_autocmd('LspAttach', {
                        group = vim.api.nvim_create_augroup('ClangdConfig', {}),
                        callback = function(ev)
                            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                            local bufopts = { noremap = true, silent = true, buffer = ev.buf }
                            vim.keymap.set("n", "gh", ":ClangdSwitchSourceHeader<CR>", bufopts)
                        end,
                    })
                    nvim_lsp.clangd.setup {
                        cmd = {
                            -- see clangd --help-hidden
                            "clangd",
                            -- default: -checks=clang-diagnostic-*,clang-analyzer-*
                            -- add-extra: .clang-tidy file in the root directory
                            -- "--cross-file-rename", -- obsolete hence ignored
                            -- "-std=c++20",
                            "--background-index",
                            "--pch-storage=memory",
                            -- "--clang-tidy",
                            "--suggest-missing-includes",
                            "--completion-style=bundled",
                            "--header-insertion=iwyu",
                        },
                        init_options = {
                            clangdFileStatus = true,
                            usePlaceholders = true,
                            completeUnimported = true,
                            semanticHighlighting = true,
                        },
                        capabilities = copy_capabilities_clangd,
                        single_file_support = true,
                        root_dir = nvim_lsp.util.root_pattern(
                            ".clangd",
                            ".clang-tidy",
                            ".clang-format",
                            "compile_flags.txt",
                            ".git",
                            "configure.ac",
                            "compile_commands.json"
                        ),
                    }
                end,
            })
        end,
    },
}
