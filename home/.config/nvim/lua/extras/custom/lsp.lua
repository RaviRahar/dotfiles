---------------------------------------------------------------
-- => Lsp-Settings
---------------------------------------------------------------
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>st", vim.diagnostic.setloclist, opts)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    update_in_insert = false,
})

local signs = {
    Error = "",
    Warn  = "",
    Info  = "",
    Hint  = "",
    Other = " ",
    -- Info = "",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        -- local opts = { buffer = ev.buf }
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }

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
        vim.keymap.set('n', "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<leader>ft", function()
            vim.lsp.buf.format({ async = true })
        end, bufopts)
        vim.keymap.set("v", "<leader>ft", function()
            vim.lsp.buf.format({ async = true })
        end, bufopts)
    end,
})
