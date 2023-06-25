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
                    "lua_ls",
                    "bashls",
                    --'pyright',
                    "jedi_language_server",
                    "rust_analyzer",
                    "clangd",
                    "jdtls",
                    "kotlin_language_server",
                    "tsserver",
                    "cmake",
                    "html",
                    "cssls",
                    "jsonls",
                    "emmet_ls",

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
                ["lua_ls"] = function()
                    nvim_lsp.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        ["/usr/share/awesome/lib"] = true,
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
            })
        end,
    },
}
