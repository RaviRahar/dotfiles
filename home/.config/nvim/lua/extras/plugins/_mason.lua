---------------------------------------------------------------
-- => To Install Lsps
---------------------------------------------------------------
return {
    {
        "williamboman/mason.nvim",
        lazy = true,
        cmd = { "Mason", "MasonUpdate" },
        config = function()
            vim.cmd([[
                augroup MasonTheme
                    autocmd!

                    autocmd VimEnter * hi! MasonHeader cterm=bold gui=bold guifg=#000000 guibg=#83a598
                    autocmd VimEnter * hi! MasonHeaderSecondary cterm=bold gui=bold guifg=#000000 guibg=#83a598
                    autocmd VimEnter * hi! MasonHighlightBlock cterm=bold gui=bold guifg=#000000 guibg=#83a598
                    autocmd VimEnter * hi! MasonHighlightBlockBold cterm=bold gui=bold guifg=#000000 guibg=#83a598
                    autocmd VimEnter * hi! MasonHighlightBlockSecondary cterm=bold gui=bold guifg=#000000 guibg=#83a598
                    autocmd VimEnter * hi! MasonHighlightBlockBoldSecondary cterm=bold gui=bold guifg=#000000 guibg=#83a598
                augroup end
            ]])

            require("mason").setup({
                ui = {
                    border = "rounded",
                },
            })
        end,
    },
}
