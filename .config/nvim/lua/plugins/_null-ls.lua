vim.cmd([[packadd mason.nvim]])
local null_ls = require("null-ls")

local function custom_attach(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    local opts = { noremap = true, silent = true }

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    buf_set_option("formatexpr", "v:lua.vim.lsp.formatexpr()")

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<leader>dt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("v", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)

    -- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "gr", ":Trouble lsp_references<CR>", { noremap = true, silent = true })

    buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float({ focusable = false })<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>di", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    buf_set_keymap("n", "<leader>ft", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
    buf_set_keymap("v", "<leader>ft", "<cmd>lua vim.lsp.buf.range_formatting({ async = true })<CR>", opts)

    -- Stops cursor from going inside popup
    --vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { focusable = false, })
    --vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false, })
    -- Auto format using LSP on save
    --vim.api.nvim_exec([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]], false)
end

null_ls.setup({
    sources = {
        -- null_ls.builtins.completion.spell,

        -- null_ls.builtins.diagnostics.codespell,
        -- null_ls.builtins.diagnostics.cpplint,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.markdownlint,
        -- null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.diagnostics.jsonlint,

        null_ls.builtins.formatting.markdownlint,
        -- null_ls.builtins.formatting.codespell,
        null_ls.builtins.formatting.black,
        -- null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        null_ls.builtins.formatting.clang_format,
        -- null_ls.builtins.formatting.clang_format.with({
        --     extra_args = { "--style={ BasedOnStyle: InheritParentConfig } --fallback-style={ BasedOnStyle: Google }" },
        -- }),
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.yamlfmt,
        null_ls.builtins.formatting.xmlformat,
        null_ls.builtins.formatting.fixjson,
    },
    -- border = nil,
    -- cmd = { "nvim" },
    -- debounce = 250,
    -- debug = false,
    -- default_timeout = 5000,
    -- diagnostic_config = nil,
    -- diagnostics_format = "#{m}",
    -- fallback_severity = vim.diagnostic.severity.ERROR,
    -- log_level = "warn",
    -- notify_format = "[null-ls] %s",
    on_attach = custom_attach,
    -- on_init = nil,
    -- on_exit = nil,
    -- root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
    -- should_attach = nil,
    -- sources = nil,
    -- temp_dir = nil,
    -- update_in_insert = false,
})
