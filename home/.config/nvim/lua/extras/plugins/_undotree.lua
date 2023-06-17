return {
    {
        "mbbill/undotree",
        lazy = true,
        cmd = "UndotreeToggle",
        config = function()
            vim.g.undotree_SplitWidth = 50
            vim.g.undotree_WindowLayout = 1
            vim.g.undotree_ShortIndicators = 1
            vim.g.undotree_DiffpanelHeight = 20
            vim.g.undotree_SetFocusWhenToggle = 1
        end,
    },
}
