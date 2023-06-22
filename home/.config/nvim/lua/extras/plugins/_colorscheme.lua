---------------------------------------------------------------
-- => Colors and Theming
---------------------------------------------------------------
return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            --vim.g.airline_powerline_fonts = 1
            vim.g.gruvbox_contrast_dark = "soft"
            vim.g.gruvbox_transparent_bg = 1
            vim.g.gruvbox_termcolors = 256
            vim.g.rehash256 = 1
            vim.cmd("colorscheme gruvbox")

            vim.cmd([[
                augroup Theme
                    autocmd!
                    autocmd VimEnter * hi! Normal ctermbg=none guibg=none
                    autocmd VimEnter * hi! LineNr ctermbg=none guibg=none
                    autocmd VimEnter * hi! SignColumn ctermbg=none guibg=none
                    "" autocmd VimEnter * hi! CursorLine ctermbg=none guibg=none

                    "" autocmd VimEnter * hi! NormalFloat guibg=none
                    autocmd VimEnter * hi! WinSeparator guibg=none
                    autocmd VimEnter * hi! LspInstallerHeader guibg=#83a598
                    autocmd VimEnter * hi! LspInstallerLabel guibg=#83a598
                    autocmd VimEnter * hi! GruvboxAquaSign ctermbg=none guibg=none
                    autocmd VimEnter * hi! GruvboxRedSign ctermbg=none guibg=none
                augroup end
            ]])
        end,
    },
}
