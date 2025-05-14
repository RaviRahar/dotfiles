-------------------------------------------------------------------
-- => To automatically setup Lsps
-------------------------------------------------------------------
return {
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile', 'BufWinEnter' },
        dependencies = {
            { "williamboman/mason.nvim",           lazy = true },
            { "williamboman/mason-lspconfig.nvim", lazy = true },
            { "nvimtools/none-ls.nvim",            lazy = true },
        },
        config = function()
            require("lspconfig.ui.windows").default_options.border = "rounded"
            vim.cmd([[
                augroup LspConfigTheme
                    autocmd!
                    autocmd VimEnter * hi! LspInstallerHeader guibg=#83a598
                    autocmd VimEnter * hi! LspInstallerLabel guibg=#83a598
                    autocmd VimEnter * hi! LspInfoBorder guibg=none
                    autocmd VimEnter * hi! LspInfoList guibg=none
                augroup end
            ]])
        end,
    },
}
