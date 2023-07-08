---------------------------------------------------------------
-- => All Plugins with no configuration required
---------------------------------------------------------------
return {
    {
        -- { Tim Pope Plugins }
        { "tpope/vim-surround",        lazy = false },
        { "tpope/vim-repeat",          lazy = false },
        { "tpope/vim-sleuth",          lazy = false },
        { "tpope/vim-fugitive",        lazy = true, cmd = { "Git", "G", "Gvdiffsplit" } },
        { "tpope/vim-commentary",      lazy = true, keys = { { "gc", mode = { "n", "v" } } } },

        { "stevearc/dressing.nvim",    lazy = false },
        { "justinmk/vim-syntax-extra", lazy = true, ft = { "flex", "lex", "yacc" } },
        { "ap/vim-css-color",          lazy = true, ft = { "css", "html" } },
    },
}
