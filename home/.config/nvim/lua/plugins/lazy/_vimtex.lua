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

            vim.g.tex_fold_enabled = 1
            vim.g.vimtex_view_method = "zathura"
            -- vim.g.vimtex_view_method = "general"
            -- vim.g.vimtex_view_general_viewer = "firefox-developer-edition"
            -- vim.g.vimtex_view_general_options = "file:@pdf#src:@line@tex"
            vim.g.vimtex_parser_bib_backend = "bibtex"
            vim.g.vimtex_syntax_enabled = 1
            vim.g.vimtex_quickfix_enabled = 1
            vim.g.vimtex_quickfix_mode = 0
            -- vim.g.tex_flavor = "latex"
            vim.g.vimtex_syntax_conceal_disable = false

            vim.g.vimtex_syntax_conceal = {
                accents = 1,
                ligatures = 1,
                cites = 1,
                fancy = 1,
                spacing = 1,
                greek = 1,
                math_bounds = 1,
                math_delimiters = 1,
                math_fracs = 1,
                math_super_sub = 1,
                math_symbols = 1,
                sections = 1,
                styles = 1,
            }
            -- vim.g.vimtex_syntax_conceal = { sections = true }
            vim.g.vimtex_compiler_latexmk = {
                aux_dir = "/tmp/latex",
                -- out_dir = '',
                -- callback = true,
                -- continuous = true,
                executable = "latexmk",
                -- hooks = {},
                options = {
                    "-lualatex",
                    "-verbose",
                    "-shell-escape",
                    "-file-line-error",
                    "-synctex=1",
                    "-interaction=nonstopmode",
                },
            }
        end,
    },
}
