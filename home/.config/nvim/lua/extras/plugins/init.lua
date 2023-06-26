---------------------------------------------------------------
-- => All Plugins with no configuration required
---------------------------------------------------------------
return {
    {
        { "ap/vim-css-color",          lazy = true, ft = { "css", "html" } },

        -- { Tim Pope Plugins }
        { "tpope/vim-surround",        lazy = false },
        { "tpope/vim-commentary",      lazy = true, keys = { { "gc", mode = { "n", "v" } } } },
        { "tpope/vim-repeat",          lazy = true, keys = { "." } },
        { "tpope/vim-sleuth",          lazy = false },

        { "stevearc/dressing.nvim",    lazy = false },
        { "justinmk/vim-syntax-extra", lazy = true, ft = { "flex", "lex", "yacc" } },
        { "tpope/vim-fugitive",        lazy = true, cmd = { "Git", "G", "Gvdiffsplit" } },
    },
}
