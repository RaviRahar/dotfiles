---------------------------------------------------------------
-- => Markdown Related Plugins
---------------------------------------------------------------
return {
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
