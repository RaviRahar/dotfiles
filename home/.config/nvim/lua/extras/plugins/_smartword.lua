return {
    {
        "anuvyklack/vim-smartword",
        config = function()
            local opts = { noremap = false, silent = true }
            vim.keymap.set("", "w", "<Plug>(smartword-w)", opts)
            vim.keymap.set("", "b", "<Plug>(smartword-b)", opts)
            vim.keymap.set("", "e", "<Plug>(smartword-e)", opts)
            vim.keymap.set("", "ge", "<Plug>(smartword-ge)", opts)
        end,
    },
}
