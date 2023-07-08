---------------------------------------------------------------
-- => To show ctags
---------------------------------------------------------------
return {
    {
        "preservim/tagbar",
        lazy = true,
        cmd = "TagbarToggle",
        config = function()
            vim.g.tagbar_width = 50
            vim.g.tagbar_autoclose_netrw = 1
            vim.g.tagbar_autofocus = 1
            vim.g.tagbar_show_data_type = 1
            vim.g.tagbar_show_visibility = 0
            vim.g.tagbar_show_linenumbers = 1
            vim.g.tagbar_show_tag_count = 1
            vim.g.tagbar_position = "botright vertical"
            -- vim.g.tagbar_height = 40
        end,
    },
}
