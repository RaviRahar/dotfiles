---------------------------------------------------------------
-- => Mason-Looks
---------------------------------------------------------------
vim.api.nvim_exec([[
    hi! MasonHeader cterm=bold gui=bold guifg=#000000 guibg=#83a598
    hi! MasonHeaderSecondary cterm=bold gui=bold guifg=#000000 guibg=#83a598
    hi! MasonHighlightBlock cterm=bold gui=bold guifg=#000000 guibg=#83a598
    hi! MasonHighlightBlockBold cterm=bold gui=bold guifg=#000000 guibg=#83a598
    hi! MasonHighlightBlockSecondary cterm=bold gui=bold guifg=#000000 guibg=#83a598
    hi! MasonHighlightBlockBoldSecondary cterm=bold gui=bold guifg=#000000 guibg=#83a598
]], false)

require("mason").setup({
    ui = {
        border = "rounded",
    }
})
