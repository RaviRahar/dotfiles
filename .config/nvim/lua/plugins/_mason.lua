---------------------------------------------------------------
-- => Lsp-Settings
---------------------------------------------------------------
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    update_in_insert = false,
})

local signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
    Other = "﫠",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

---------------------------------------------------------------
-- => Dependencies
---------------------------------------------------------------
vim.cmd([[packadd! cmp-nvim-lsp]])
vim.cmd([[packadd! nvim-lspconfig]])
vim.cmd([[packadd! mason-lspconfig.nvim]])

---------------------------------------------------------------
-- => Lsp-Config and Nvim-Cmp
---------------------------------------------------------------
local nvim_lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

---------------------------------------------------------------
-- => Mason
---------------------------------------------------------------
vim.cmd([[
    hi! MasonHeader cterm=bold gui=bold guifg=#000000 guibg=#83a598
    hi! MasonHeaderSecondary cterm=bold gui=bold guifg=#000000 guibg=#83a598
    hi! MasonHighlightBlock cterm=bold gui=bold guifg=#000000 guibg=#83a598
    hi! MasonHighlightBlockBold cterm=bold gui=bold guifg=#000000 guibg=#83a598
    hi! MasonHighlightBlockSecondary cterm=bold gui=bold guifg=#000000 guibg=#83a598
    hi! MasonHighlightBlockBoldSecondary cterm=bold gui=bold guifg=#000000 guibg=#83a598
]])

require("mason").setup({
    ui = {
        border = "rounded",
    },
})

---------------------------------------------------------------
-- => Mason-Lspconfig
---------------------------------------------------------------
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
    ensure_installed = {
        "sumneko_lua",
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

local custom_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    -- vim.keymap.set('n', '<leader>dt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", bufopts)
    vim.keymap.set("n", "<leader>ft", function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
    vim.keymap.set("v", "<leader>ft", function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
end

local function switch_source_header_splitcmd(bufnr, splitcmd)
    bufnr = nvim_lsp.util.validate_bufnr(bufnr)
    local clangd_client = nvim_lsp.util.get_active_client_by_name(bufnr, "clangd")
    local params = { uri = vim.uri_from_bufnr(bufnr) }
    if clangd_client then
        clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
            if err then
                error(tostring(err))
            end
            if not result then
                print("Corresponding file can’t be determined")
                return
            end
            vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
        end)
    else
        print("method textDocument/switchSourceHeader is not supported by any servers active on the current buffer")
    end
end

--------------------------------------------------------------
-- => Server-Configs
---------------------------------------------------------------

mason_lspconfig.setup_handlers({
    function(server_name)
        if server_name == "gopls" then
            nvim_lsp.gopls.setup({
                on_attach = custom_attach,
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
        elseif server_name == "sumneko_lua" then
            nvim_lsp.sumneko_lua.setup({
                capabilities = capabilities,
                on_attach = custom_attach,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim", "packer_plugins" } },
                        workspace = {
                            library = {
                                vim.api.nvim_get_runtime_file("", true),
                                -- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                -- [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                            },
                            maxPreload = 100000,
                            preloadFileSize = 10000,
                        },
                        telemetry = { enable = false },
                    },
                },
            })
        elseif server_name == "clangd" then
            local copy_capabilities = capabilities
            copy_capabilities.offsetEncoding = { "utf-16" }
            nvim_lsp.clangd.setup({
                capabilities = copy_capabilities,
                single_file_support = true,
                on_attach = custom_attach,
                args = {
                    "--background-index",
                    "-std=c++20",
                    "--pch-storage=memory",
                    "--clang-tidy",
                    "--suggest-missing-includes",
                },
                root_dir = nvim_lsp.util.root_pattern(
                    ".clangd",
                    ".clang-tidy",
                    ".clang-format",
                    "compile_flags.txt",
                    ".git",
                    "configure.ac",
                    "compile_commands.json"
                ),
                commands = {
                    ClangdSwitchSourceHeader = {
                        function()
                            switch_source_header_splitcmd(0, "edit")
                        end,
                        description = "Open source/header in current buffer",
                    },
                    ClangdSwitchSourceHeaderVSplit = {
                        function()
                            switch_source_header_splitcmd(0, "vsplit")
                        end,
                        description = "Open source/header in a new vsplit",
                    },
                    ClangdSwitchSourceHeaderSplit = {
                        function()
                            switch_source_header_splitcmd(0, "split")
                        end,
                        description = "Open source/header in a new split",
                    },
                },
            })
        elseif server_name == "jsonls" then
            nvim_lsp.jsonls.setup({
                flags = { debounce_text_changes = 500 },
                capabilities = capabilities,
                on_attach = custom_attach,
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
        elseif server_name == "kotlin_language_server" then
            nvim_lsp.kotlin_language_server.setup({
                capabilities = capabilities,
                on_attach = custom_attach,
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
        else
            nvim_lsp[server_name].setup({
                capabilities = capabilities,
                on_attach = custom_attach,
                flags = { debounce_text_changes = 150 },
            })
        end
    end,
})
