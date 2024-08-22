---------------------------------------------------------------
-- => Indent Lines
---------------------------------------------------------------
return {
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = true,
        main = "ibl",
        event = { "CursorMoved", "InsertEnter" },
        config = function()
            require("ibl").setup({
                indent = {
                    char = "|",
                    tab_char = "|",
                },
                scope = {
                    enabled = false
                },
                exclude = {
                    filetypes = {
                        "FTerm",
                        "alpha",
                        "packer",
                        "NvimTree",
                        "conf",
                        "alpha",
                    }
                }
            })
        end,
    },
}
