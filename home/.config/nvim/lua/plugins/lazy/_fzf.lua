---------------------------------------------------------------
-- => Fzf for fuzzy finding
---------------------------------------------------------------
return {
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        cmd = { "FzfLua" },
        dependencies = {
            { "kyazdani42/nvim-web-devicons", lazy = true },
            { "RaviRahar/fzf-combi-mode",     lazy = true, cmd = { "FzfCombiMode" } },
            -- { dir = "/home/shush/3-Fun/gitclones/fzf-combi-mode",     lazy = true, cmd = { "FzfCombiMode" } },
            {
                "junegunn/fzf",
                lazy = true,
                build = "./install --bin"
            },
        },
        config = function()
            local actions = require("fzf-lua.actions")

            require("fzf-lua").setup({
                "default", -- telescope
                lsp = {
                    -- make lsp requests synchronous so they work with null-ls
                    async_or_timeout = 3000,
                },
                winopts = {
                    height  = 0.85,
                    width   = 0.80,
                    row     = 0.35,
                    col     = 0.50,
                    border  = "rounded",
                    preview = {
                        vertical    = 'down:45%',
                        horizontal  = 'right:55%',
                        title       = true,
                        title_pos   = "left",
                        scrollbar   = false,
                        delay       = 60,
                        winopts     = { -- builtin previewer window options
                            number         = true,
                            relativenumber = false,
                            cursorline     = true,
                            cursorlineopt  = 'both',
                            cursorcolumn   = false,
                            signcolumn     = 'no',
                            list           = false,
                            foldenable     = false,
                            foldmethod     = 'manual',
                        },
                    },
                },
                keymap = {
                    -- These override the default tables completely
                    -- no need to set to `false` to disable a bind
                    -- delete or modify is sufficient
                    builtin = {
                        -- neovim `:tmap` mappings for the fzf win
                        ["<A-h>"]    = "toggle-help",
                        ["<A-f>"]    = "toggle-fullscreen",
                        -- Only valid with the 'builtin' previewer
                        ["<A-w>"]    = "toggle-preview-wrap",
                        ["<A-p>"]    = "toggle-preview",
                        ["<S-down>"] = "preview-page-down",
                        ["<S-up>"]   = "preview-page-up",
                        ["<S-left>"] = "preview-page-reset",
                    },
                    fzf = {
                        -- fzf '--bind=' options
                        -- ["ctrl-["]     = "abort",
                        -- ["ctrl-c"]     = "abort",
                        ["ctrl-c"]     = "unix-line-discard",
                        ["ctrl-u"]     = "half-page-down",
                        ["ctrl-d"]     = "half-page-up",
                        ["ctrl-a"]     = "beginning-of-line",
                        ["ctrl-e"]     = "end-of-line",
                        ["alt-t"]      = "toggle-all",
                        -- Only valid with fzf previewers (bat/cat/git/etc)
                        ["alt-w"]      = "toggle-preview-wrap",
                        ["alt-p"]      = "toggle-preview",
                        ["shift-down"] = "preview-page-down",
                        ["shift-up"]   = "preview-page-up",
                    },
                },
                actions = {
                    files = {
                        -- ["default"]     = actions.file_edit,
                        ["default"] = actions.file_edit_or_qf,
                        ["ctrl-h"]  = actions.file_split,
                        ["ctrl-v"]  = actions.file_vsplit,
                        ["ctrl-t"]  = actions.file_tabedit,
                        ["ctrl-q"]  = actions.file_sel_to_qf,
                        ["ctrl-l"]  = actions.file_sel_to_ll,
                    },
                    buffers = {
                        -- providers that inherit these actions:
                        --   buffers, tabs, lines, blines
                        ["default"] = actions.buf_edit,
                        ["ctrl-h"]  = actions.buf_split,
                        ["ctrl-v"]  = actions.buf_vsplit,
                        ["ctrl-t"]  = actions.buf_tabedit,
                        ["ctrl-q"]  = { fn = actions.buf_del, reload = true },
                    },
                    tabs = {
                        ["ctrl-q"] = { fn = actions.buf_del, reload = true },
                    },
                },
                fzf_colors = {
                    -- ["hl"]     = { "fg", "Statement" },
                    -- ["fg+"]    = { "fg", "#fbf1c7" },
                    -- ["bg+"]    = { "bg", "GruvboxBg0" },
                    ["bg+"]    = { "bg", "CursorLine" },
                    -- ["hl+"]    = { "fg", "Statement" },
                    -- ["prompt"] = { "fg", "Statement" },
                    --
                    -- ["fg"]      = { "fg", "Normal" },
                    -- ["bg"]      = { "bg", "Normal" },
                    -- ["info"]    = { "fg", "PreProc" },
                    -- ["pointer"] = { "fg", "Exception" },
                    -- ["marker"]  = { "fg", "Keyword" },
                    -- ["spinner"] = { "fg", "Label" },
                    -- ["header"]  = { "fg", "Comment" },
                    -- ["gutter"] = { "bg", "GruvboxGb0" },
                    ["gutter"] = { "bg", "Normal" },
                },
            })
        end,
    },
}
