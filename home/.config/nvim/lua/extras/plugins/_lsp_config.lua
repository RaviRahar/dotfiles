---------------------------------------------------------------
-- => Lsp Config Plugin
---------------------------------------------------------------
return {
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile', 'BufWinEnter' },
        dependencies = {
            { "williamboman/mason-lspconfig.nvim", lazy = true },
            { "jose-elias-alvarez/null-ls.nvim",   lazy = true },
            { "williamboman/mason.nvim",           lazy = true },
        },
        config = function()
            require("lspconfig.ui.windows").default_options.border = "rounded"

            if vim.g.colors_name == "gruvbox" then
                if vim.o.background == "dark" then
                    vim.cmd([[
                        augroup LspConfigTheme
                            autocmd!
                            autocmd VimEnter * hi! LspInfoBorder guifg=#ebdbb2 guibg=#282828
                            autocmd VimEnter * hi! LspInfoList guifg=#ebdbb2 guibg=#282828
                        augroup end
                    ]])
                elseif vim.o.background == "light" then
                    vim.cmd([[
                        augroup LspConfigTheme
                            autocmd!
                            autocmd VimEnter * hi! LspInfoBorder guifg=#282828 guibg=#ebdbb2
                            autocmd VimEnter * hi! LspInfoList guifg=#282828 guibg=#ebdbb2
                        augroup end
                    ]])
                end
            end
        end,
    },
}
