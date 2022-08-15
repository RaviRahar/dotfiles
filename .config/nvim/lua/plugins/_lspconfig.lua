---------------------------------------------------------------
-- => Dependencies
---------------------------------------------------------------
vim.cmd([[packadd nvim-lsp-installer]])
vim.cmd([[packadd cmp-nvim-lsp]])
---------------------------------------------------------------
-- => Lsp-Looks
---------------------------------------------------------------
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    update_in_insert = false,
})

local signs = {
    Error = "",
    Warn  = "",
    Hint  = "",
    Info  = "",
    Other = "﫠",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

---------------------------------------------------------------
-- => Lsp-Settings
---------------------------------------------------------------
local lsp_installer = require('nvim-lsp-installer')
lsp_installer.setup({
    ensure_installed = {
        'sumneko_lua',
        'bashls',
        --'pyright',
        'jedi_language_server',
        'rust_analyzer',
        'clangd',
        'jdtls',
        'kotlin_language_server',
        'tsserver',
        'cmake',
        'html',
        'cssls',
        'jsonls',
    }
})
local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local function custom_attach(client, bufnr)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    local opts = { noremap = true, silent = true }

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    buf_set_option('formatexpr', 'v:lua.vim.lsp.formatexpr()')


    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>dt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float({ focusable = false })<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>di', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<leader>ft', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
    buf_set_keymap('v', '<leader>ft', '<cmd>lua vim.lsp.buf.range_formatting({ async = true })<CR>', opts)

    -- Stops cursor from going inside popup
    --vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { focusable = false, })
    --vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false, })
    -- Auto format using LSP on save
    --vim.api.nvim_exec([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]], false)

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
for _, server in ipairs(lsp_installer.get_installed_servers()) do
    if server.name == "gopls" then
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
    elseif server.name == "sumneko_lua" then
        nvim_lsp.sumneko_lua.setup({
            capabilities = capabilities,
            on_attach = custom_attach,
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim", "packer_plugins" } },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                    telemetry = { enable = false },
                },
            },
        })
    elseif server.name == "clangd" then
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
    elseif server.name == "jsonls" then
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
    elseif server.name == "kotlin_language_server" then
        nvim_lsp.kotlin_language_server.setup({
            capabilities = capabilities,
            on_attach = custom_attach,
            flags = { debounce_text_changes = 150, },
            settings = {
                kotlin = {
                    debounceTime = 150,
                    linting = { debounceTime = 150 },
                    indexing = { enabled = false },
                    debugAdapter = { enabled = false },
                    completion = { snippets = { enabled = true } },
                }
            }
        })
    else
        nvim_lsp[server.name].setup({
            capabilities = capabilities,
            on_attach = custom_attach,
            flags = { debounce_text_changes = 150, },
        })
    end
end
