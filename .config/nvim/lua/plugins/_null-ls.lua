require("plugins._mason")

local null_ls = require("null-ls")

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
    on_attach = custom_attach,
    -- on_init = nil,
    -- on_exit = nil,
    -- root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
    -- should_attach = nil,
    -- sources = nil,
    -- temp_dir = nil,
    -- update_in_insert = false,
    sources = {
        null_ls.builtins.code_actions.eslint_d,
        -- null_ls.builtins.diagnostics.eslint_d,
        -- null_ls.builtins.formatting.eslint_d,

        -- null_ls.builtins.completion.spell,

        -- null_ls.builtins.diagnostics.codespell,
        -- null_ls.builtins.diagnostics.cpplint,
        -- null_ls.builtins.diagnostics.flake8,
        -- null_ls.builtins.diagnostics.markdownlint,
        -- null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.diagnostics.jsonlint,

        -- null_ls.builtins.formatting.markdownlint,
        -- null_ls.builtins.formatting.codespell,
        null_ls.builtins.formatting.black,
        -- null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        null_ls.builtins.formatting.clang_format,
        -- null_ls.builtins.formatting.clang_format.with({
        --     extra_args = { "--style={ BasedOnStyle: InheritParentConfig } --fallback-style={ BasedOnStyle: Google }" },
        -- }),
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.formatting.yamlfmt,
        null_ls.builtins.formatting.xmlformat,
        null_ls.builtins.formatting.fixjson,
    },
})
