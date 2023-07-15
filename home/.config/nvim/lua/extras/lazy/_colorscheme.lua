---------------------------------------------------------------
-- => Colors and Theming
---------------------------------------------------------------
return {
    {
        "ellisonleao/gruvbox.nvim",
        -- "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        config = function(plugin)
            -- EverForest
            -- vim.cmd("colorscheme everforest")
            -- vim.g.everforest_background = "soft"
            -- vim.g.everforest_better_performance = 1

            -- Gruvbox

            vim.g.airline_powerline_fonts = 1
            vim.g.gruvbox_contrast_dark = "soft"
            vim.g.gruvbox_contrast_light = "soft"
            vim.g.gruvbox_transparent_bg = 1
            vim.g.gruvbox_termcolors = 256
            vim.g.rehash256 = 1
            vim.cmd("colorscheme gruvbox")

            vim.cmd([[
                augroup Theme
                    autocmd!
                    autocmd VimEnter * hi! clear NonText
                    autocmd VimEnter * hi! clear ModeMsg
                    autocmd VimEnter * hi! clear MoreMsg
                    autocmd VimEnter * hi! clear ModeArea
                    autocmd VimEnter * hi! clear ErrorMsg
                    autocmd VimEnter * hi! clear Error
                    " autocmd VimEnter * hi! clear Directory
                    autocmd VimEnter * hi! clear VertSplit
                    autocmd VimEnter * hi! clear SignColumn
                    autocmd VimEnter * hi! clear EndOfBuffer
                    autocmd VimEnter * hi! clear Folded
                    autocmd VimEnter * hi! clear Normal
                    autocmd VimEnter * hi! clear SignColumn
                    autocmd VimEnter * hi! clear Cursor
                    autocmd VimEnter * hi! CursorLineNr cterm=bold
                    autocmd VimEnter * hi! LineNr guifg=#9c8f84
                    " autocmd VimEnter * hi! Visual guibg=#83a598 guifg=#222222
                    " autocmd VimEnter * hi! CursorLine ctermbg=none guibg=none

                    autocmd VimEnter * hi! NormalFloat guibg=none
                    autocmd VimEnter * hi! WinSeparator guibg=none
                    autocmd VimEnter * hi! GruvboxAquaSign ctermbg=none guibg=none
                    autocmd VimEnter * hi! GruvboxRedSign ctermbg=none guibg=none
                    " autocmd VimEnter * hi!  DiagnosticUnderlineOk cterm=undercurl gui=undercurl guisp=LightGreen
                    " autocmd VimEnter * hi!  DiagnosticUnderlineHint cterm=undercurl gui=undercurl guisp=#8ec07c
                    " autocmd VimEnter * hi!  DiagnosticUnderlineInfo cterm=undercurl gui=undercurl guisp=#83a598
                    " autocmd VimEnter * hi!  DiagnosticUnderlineWarn cterm=undercurl gui=undercurl guisp=#fabd2f
                    " autocmd VimEnter * hi!  DiagnosticUnderlineError cterm=undercurl gui=undercurl guisp=#fb4934
                    autocmd VimEnter * hi!  DiagnosticUnderlineError cterm=undercurl gui=undercurl guisp=yellow
                    " autocmd VimEnter * hi!  DiagnosticUnderlineError cterm=undercurl gui=undercurl guisp=red

                augroup end
            ]])
        end,
    },
}
