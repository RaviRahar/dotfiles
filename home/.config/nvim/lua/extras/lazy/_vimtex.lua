---------------------------------------------------------------
-- => For Latex files
---------------------------------------------------------------
return {
    {
        "lervag/vimtex",
        lazy = true,
        ft = { "tex", "plaintex" },
        init = function()
            vim.cmd([[ autocmd VimEnter * hi! clear MatchParen ]])
            vim.g.vimtex_view_method = "general"
            vim.g.vimtex_view_general_viewer = "firefox-developer-edition"
            vim.g.vimtex_view_general_options = "file:@pdf#src:@line@tex"
            vim.g.vimtex_syntax_enabled = false
            vim.g.vimtex_compiler_latexmk = {
                aux_dir = "/tmp/latex",
                -- out_dir = '',
                -- callback = true,
                -- continuous = true,
                -- executable = 'latexmk',
                -- hooks = {},
                -- options = {
                --     '-verbose',
                --     '-file-line-error',
                --     '-synctex=1',
                --     '-interaction=nonstopmode',
                -- }
            }
            -- vim.g.vimtex_quickfix_enabled = 1
            -- vim.g.vimtex_syntax_enabled = 1
            -- vim.g.vimtex_quickfix_mode = 0
            -- vim.g.tex_flavor = "latex"
        end,
    },
}
