---------------------------------------------------------------
-- => Customizable statusline
---------------------------------------------------------------
return {
    {
        "nvim-lualine/lualine.nvim",
        lazy = true,
        event = "VimEnter",
        dependencies = {
            { "kyazdani42/nvim-web-devicons", lazy = true },
            { "arkav/lualine-lsp-progress",   lazy = true },
        },
        config = function()
            local colors = nil

            if vim.g.colors_name == "gruvbox" then
                if vim.o.background == "dark" then
                    colors = {
                        blacktext = "#282828",
                        whitetext = "#ebdbb2",
                        altwhitetext = "#cbbba2",
                        background = "#484848",
                        altbackground = "#282828",
                        skyblue = "#83a598",
                        lightskyblue = "#c3e5d8",
                        green = "#689d6a",
                        lightgreen = "#a8ddaa",
                        yellow = "#fabd2f",
                        lightyellow = "#ffed5f",
                        red = "#cc241d",
                        lightred = "#fc645d",
                        purple = "#b16286",
                        lightpurple = "#f1a2c6",
                        white = "#cbbba2",
                    }
                elseif vim.o.background == "light" then
                    colors = {
                        blacktext = "#282828",
                        whitetext = "#282828",
                        altwhitetext = "#484848",
                        background = "#d5c4a1",
                        altbackground = "#d5c4a1",
                        skyblue = "#83a598",
                        lightskyblue = "#83a598",
                        green = "#689d6a",
                        lightgreen = "#689d6a",
                        yellow = "#b57614",
                        lightyellow = "#b57614",
                        red = "#cc241d",
                        lightred = "#cc241d",
                        purple = "#b16286",
                        lightpurple = "#b16286",
                        white = "#a89984",
                    }
                else
                    colors = {
                        blacktext = "#282828",
                        whitetext = "#ebdbb2",
                        altwhitetext = "#cbbba2",
                        background = "#484848",
                        altbackground = "#282828",
                        skyblue = "#83a598",
                        lightskyblue = "#c3e5d8",
                        green = "#689d6a",
                        lightgreen = "#a8ddaa",
                        yellow = "#fabd2f",
                        lightyellow = "#ffed5f",
                        red = "#cc241d",
                        lightred = "#fc645d",
                        purple = "#b16286",
                        lightpurple = "#f1a2c6",
                        white = "#cbbba2",
                    }
                end
            end

            local custom_gruvbox = {
                normal = {
                    a = { bg = colors.skyblue, fg = colors.blacktext, gui = "bold" },
                    b = { bg = colors.lightskyblue, fg = colors.blacktext },
                    c = { bg = colors.background, fg = colors.whitetext },
                    x = { bg = colors.white, fg = colors.blacktext },
                    y = { bg = colors.background, fg = colors.whitetext },
                    z = { bg = colors.lightskyblue, fg = colors.blacktext },
                },
                insert = {
                    a = { bg = colors.green, fg = colors.blacktext, gui = "bold" },
                    b = { bg = colors.lightgreen, fg = colors.blacktext },
                    x = { bg = colors.background, fg = colors.whitetext },
                    y = { bg = colors.lightgreen, fg = colors.blacktext },
                    z = { bg = colors.white, fg = colors.blacktext },
                },
                visual = {
                    a = { bg = colors.yellow, fg = colors.blacktext, gui = "bold" },
                    b = { bg = colors.lightyellow, fg = colors.blacktext },
                    x = { bg = colors.background, fg = colors.whitetext },
                    y = { bg = colors.lightyellow, fg = colors.blacktext },
                    z = { bg = colors.white, fg = colors.blacktext },
                },
                replace = {
                    a = { bg = colors.red, fg = colors.altwhitetext, gui = "bold" },
                    b = { bg = colors.lightred, fg = colors.blacktext },
                    x = { bg = colors.background, fg = colors.whitetext },
                    y = { bg = colors.lightred, fg = colors.blacktext },
                    z = { bg = colors.white, fg = colors.blacktext },
                },
                command = {
                    a = { bg = colors.purple, fg = colors.blacktext, gui = "bold" },
                    b = { bg = colors.lightpurple, fg = colors.blacktext },
                    x = { bg = colors.background, fg = colors.whitetext },
                    y = { bg = colors.lightpurple, fg = colors.blacktext },
                    z = { bg = colors.white, fg = colors.blacktext },
                },
                inactive = {
                    a = { bg = colors.background, fg = colors.whitetext },
                    b = { bg = colors.background, fg = colors.whitetext },
                    c = { bg = colors.background, fg = colors.whitetext },
                },
            }

            require("lualine").setup({
                options = {
                    theme = custom_gruvbox,
                    disabled_filetypes = {},
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff" },
                    lualine_c = { "filename", "lsp_progress" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "diagnostics", "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                },
                tabline = {
                    lualine_a = { "buffers" },
                    lualine_y = { "tabs" },
                },
                winbar = {},
                inactive_winbar = {},
                -- extensions = { "fugitive", "fzf", "quickfix" },
            })
        end,
    },
}
