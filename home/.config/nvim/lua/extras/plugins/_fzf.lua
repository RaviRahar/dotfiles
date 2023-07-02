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
            {
                "junegunn/fzf",
                lazy = true,
                build = function()
                    vim.fn["fzf#install"]()
                end,
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
                        title_align = "left",
                        scrollbar   = false,
                    },
                },
                keymap = {
                    -- These override the default tables completely
                    -- no need to set to `false` to disable a bind
                    -- delete or modify is sufficient
                    builtin = {
                        -- neovim `:tmap` mappings for the fzf win
                        ["alt-h"]    = "toggle-help",
                        ["alt-f"]    = "toggle-fullscreen",
                        -- Only valid with the 'builtin' previewer
                        ["alt-w"]    = "toggle-preview-wrap",
                        ["alt-p"]    = "toggle-preview",
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
                    }
                },
                fzf_colors = {
                    -- ["hl"]     = { "fg", "Statement" },
                    -- ["fg+"]    = { "fg", "GruvboxFg0" },
                    -- ["bg+"]    = { "bg", "CursorLine" },
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
                    -- ["gutter"]  = { "bg", "Normal" },
                },
            })
        end,
    },
}
