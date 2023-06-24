---------------------------------------------------------------
-- => All Plugins with no configuration required
---------------------------------------------------------------
return {
    {
        { "ap/vim-css-color",          lazy = true, ft = { "css", "html" } },

        -- { Tim Pope Plugins }
        { "tpope/vim-surround",        lazy = false },
        { "tpope/vim-commentary",      lazy = false },
        { "tpope/vim-repeat",          lazy = false },
        { "tpope/vim-sleuth",          lazy = false },

        { "stevearc/dressing.nvim",    lazy = false },
        { "justinmk/vim-syntax-extra", lazy = false },
        { "tpope/vim-fugitive",        lazy = true, cmd = { "Git", "G", "Gvdiffsplit" } },
    },
}
