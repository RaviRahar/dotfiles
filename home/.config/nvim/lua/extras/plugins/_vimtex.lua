---------------------------------------------------------------
-- => For Latex files
---------------------------------------------------------------
return {
    {
        "lervag/vimtex",
        ft = { "tex", "plaintex" },
        config = function()
            vim.g.vimtex_view_method = "firefox"
            vim.g.vimtex_view_general_viewer = "firefox"
            vim.g.vimtex_view_general_options = "file:@pdf#src:@line@tex"
        end,
    },
}
