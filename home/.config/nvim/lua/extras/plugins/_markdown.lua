return {
    {
        "ellisonleao/glow.nvim",
        branch = "main",
        lazy = true,
        ft = "markdown",
        cmd = { "Glow" },
        config = function()
            require("glow").setup({
                border = "rounded",
                -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        lazy = true,
        ft = { "markdown" },
        cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewStop" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },
}
