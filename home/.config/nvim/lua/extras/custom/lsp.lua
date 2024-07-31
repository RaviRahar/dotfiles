---------------------------------------------------------------
-- => Lsp-Settings
---------------------------------------------------------------
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>wt", vim.diagnostic.setqflist, opts)
vim.keymap.set("n", "<leader>st", vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "<leader>sd", ":ToggleLspDiagnostics<CR>", opts)

local diagnostics_list = {
    signs = false,
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = false,
    update_in_insert = true,
    severity_sort = true,
}
vim.diagnostic.config(diagnostics_list)

local is_toggle_manual = not diagnostics_list.signs
vim.api.nvim_create_user_command("ToggleLspDiagnostics", function()
    if is_toggle_manual == true then
        is_toggle_manual = false
    else
        is_toggle_manual = true
    end
    if diagnostics_list.signs == true then
        diagnostics_list.signs = false
    else
        diagnostics_list.signs = true
    end
    vim.diagnostic.config(diagnostics_list)
end, {})

vim.lsp.handlers['textDocument/references'] = function(_, result, ctx, config)
    if not result or vim.tbl_isempty(result) then
        vim.notify('No references found')
        return
    end

    local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
    config = config or {}
    local title = 'References'
    local items = vim.lsp.util.locations_to_items(result, client.offset_encoding)

    local list = { title = title, items = items, context = ctx }
    if config.loclist then
        vim.fn.setloclist(0, {}, ' ', list)
        vim.notify(#items .. ' references submitted to loclist')
        -- vim.cmd.lopen()
    elseif config.on_list then
        assert(vim.is_callable(config.on_list), 'on_list is not a function')
        config.on_list(list)
    else
        vim.fn.setqflist({}, ' ', list)
        vim.notify(#items .. ' references submitted to quickfix')
        -- vim.cmd('botright copen')
    end
end

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup('ToggleLspDiagnostics', {}),
    callback = function()
        if is_toggle_manual == false then
            vim.cmd([[ToggleLspDiagnostics]])
            is_toggle_manual = false
        end
    end,
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
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<leader>ft", function()
            vim.lsp.buf.format({ async = true })
        end, bufopts)
        vim.keymap.set("v", "<leader>ft", function()
            vim.lsp.buf.format({ async = true })
        end, bufopts)
    end,
})
