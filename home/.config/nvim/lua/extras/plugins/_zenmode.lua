return {
    {
        "folke/zen-mode.nvim",
        lazy = true,
        cmd = { "ZenMode" },
        config = function()
            require("zen-mode").setup({
                window = { backdrop = 1, width = 100, options = { number = false, relativenumber = false } },
            })
        end,
    },
}
