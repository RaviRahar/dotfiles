---------------------------------------------------------------
-- => Lsp-Settings
---------------------------------------------------------------
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
vim.keymap.set("n", "<leader>sw", vim.diagnostic.setqflist, opts)
vim.keymap.set("n", "<leader>se", vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "<leader>sd", ":ToggleLspDiagnosticSigns<CR>", opts)
vim.keymap.set("n", "<leader>su", "<cmd>ToggleLspDiagnosticUnderline<CR>", opts)

-- Deprecated, just for reference
-- local signs = {
--     Error = "",
--     Warn  = "",
--     Info  = "",
--     Hint  = "",
--     Other = " ",
--     -- Info = "",
-- }

-- for type, icon in pairs(signs) do
--     local hl = "DiagnosticSign" .. type
--     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

local enabled = { signs = true, underline = true }
local enabled_config = {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
        },
        --     -- linehl = {
        --     --     [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
        --     -- },
        --     -- numhl = {
        --     --     [vim.diagnostic.severity.WARN] = 'WarningMsg',
        --     -- },
        -- },
    },
    underline = { severity = vim.diagnostic.severity.ERROR },
}

local function diagnostic_value(option)
    -- Not usefull as keybind only works in normal mode
    -- local mode = vim.fn.mode()
    -- if option == "signs" and (mode == "i" or mode == "R") then
    --     return false
    -- end
    return enabled[option] and enabled_config[option] or false
end

local function toggle_diagnostic(opt)
    enabled[opt] = not enabled[opt]
    vim.diagnostic.config({ [opt] = diagnostic_value(opt) })
    vim.notify("Diagnostic " .. opt .. (enabled[opt] and " enabled" or " disabled"))
end

vim.api.nvim_create_user_command("ToggleLspDiagnosticSigns", function() toggle_diagnostic("signs") end, {})
vim.api.nvim_create_user_command("ToggleLspDiagnosticUnderline", function() toggle_diagnostic("underline") end, {})

-- Auto-toggle in and out of insert mode
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("ToggleLspDiagnosticSigns", { clear = true }),
    callback = function(event)
        if enabled.signs then
            vim.diagnostic.config({ signs = event.event == "InsertLeave" and enabled_config.signs or false })
        end
    end,
})

-- Set initial diagnostics config
vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true,
    severity_sort = true,
    signs = diagnostic_value("signs"),
    underline = diagnostic_value("underline"),
})

vim.lsp.handlers["textDocument/references"] = function(_, result, ctx, config)
    if not result or vim.tbl_isempty(result) then
        vim.notify("No references found")
        return
    end

    local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
    config = config or {}
    local title = "References"
    local items = vim.lsp.util.locations_to_items(result, client.offset_encoding)

    local list = { title = title, items = items, context = ctx }
    if config.loclist then
        vim.fn.setloclist(0, {}, " ", list)
        vim.notify(#items .. " references submitted to loclist")
        -- vim.cmd.lopen()
    elseif config.on_list then
        assert(vim.is_callable(config.on_list), "on_list is not a function")
        config.on_list(list)
    else
        vim.fn.setqflist({}, " ", list)
        vim.notify(#items .. " references submitted to quickfix")
        -- vim.cmd([[ botright copen ]])
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
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
        vim.keymap.set("n", "sr", function(...)
            vim.lsp.buf.references(...)
            vim.cmd([[ botright copen ]])
        end, bufopts)
        vim.keymap.set("n", "<leader>ft", function()
            vim.lsp.buf.format({ async = true })
        end, bufopts)
        vim.keymap.set("v", "<leader>ft", function()
            vim.lsp.buf.format({ async = true })
        end, bufopts)
    end,
})
