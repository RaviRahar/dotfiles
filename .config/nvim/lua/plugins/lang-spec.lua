---------------------------------------------------------------
-- => Dependencies
---------------------------------------------------------------
vim.cmd([[packadd! cmp-nvim-lsp]])
---------------------------------------------------------------
-- => Language Specific Tools
---------------------------------------------------------------
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
local capabilities = require("cmp_nvim_lsp").default_capabilities()

if
    vim.bo.filetype == "c"
    or vim.bo.filetype == "cpp"
    or vim.bo.filetype == "c"
    or vim.bo.filetype == "cpp"
    or vim.bo.filetype == "objc"
    or vim.bo.filetype == "objcpp"
    or vim.bo.filetype == "cuda"
    or vim.bo.filetype == "proto"
then
    require("clangd_extensions").prepare()
end

if
    vim.bo.filetype == "html"
    or vim.bo.filetype == "css"
    or vim.bo.filetype == "xml"
    or vim.bo.filetype == "sass"
    or vim.bo.filetype == "javascript"
    or vim.bo.filetype == "typescript"
    or vim.bo.filetype == "typescriptreact"
    or vim.bo.filetype == "javascriptreact"
then
    -- emmet setup for now, don't know lua
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    local configs = require("lspconfig.configs")

    if not configs.ls_emmet then
        configs.ls_emmet = {
            default_config = {
                cmd = { "ls_emmet", "--stdio" },
                filetypes = {
                    "html",
                    "css",
                    "scss",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "haml",
                    "xml",
                    "xsl",
                    "pug",
                    "slim",
                    "sass",
                    "stylus",
                    "less",
                    "sss",
                },
                root_dir = function(fname)
                    return vim.loop.cwd()
                end,
                settings = {},
            },
        }
    end
    require("lspconfig").ls_emmet.setup({ capabilities = capabilities })
end

if vim.bo.filetype == "dart" then
    -- alternatively you can override the default configs
    require("flutter-tools").setup({
        ui = {
            -- the border type to use for all floating windows, the same options/formats
            -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
            border = "rounded",
            notification_style = "plugin",
        },
        decorations = {
            statusline = {
                app_version = true,
                device = true,
            },
        },
        widget_guides = {
            enabled = true,
        },
        closing_tags = {
            highlight = "ErrorMsg", -- highlight for the closing tag
            prefix = ">", -- character to use for close tag e.g. > Widget
            enabled = true, -- set to false to disable
        },
        lsp = {
            color = { -- show the derived colours for dart variables
                enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
                background = false, -- highlight the background
                foreground = false, -- highlight the foreground
                virtual_text = true, -- show the highlight using virtual text
                virtual_text_str = "■", -- the virtual text character to highlight
            },
            on_attach = custom_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
        },
    })

    --------------------------------------------------------------
    -- => Flutter-tools Shortcuts
    ---------------------------------------------------------------
    --Shortcuts
    vim.keymap.set("n", "<leader>Fs", ":FlutterRun<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>Fd", ":FlutterDevices<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>Fe", ":FlutterEmulators<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>Fr", ":FlutterReload<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>Fa", ":FlutterRestart<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>Fq", ":FlutterQuit<CR>", { noremap = true, silent = true })
end
