---------------------------------------------------------------
-- => Telescope Settings
---------------------------------------------------------------
vim.cmd([[packadd sqlite.lua]])
vim.cmd([[packadd telescope-fzf-native.nvim]])
vim.cmd([[packadd telescope-project.nvim]])
vim.cmd([[packadd telescope-frecency.nvim]])

vim.api.nvim_exec(
    [[
    hi! TelescopeTitle cterm=bold gui=bold guifg=#000000 guibg=#83a598
]],
    false
)

local fixfolds = {
    hidden = true,
    attach_mappings = function(_)
        require("telescope.actions.set").select:enhance({
            post = function()
                vim.cmd(":normal! zx")
            end,
        })
        return true
    end,
}

require("telescope").setup({
    defaults = {
        content_spec_column = false,
        initial_mode = "insert",
        prompt_prefix = "  ",
        scroll_strategy = "limit",
        results_title = false,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        -- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        path_display = { "smart" },
        file_ignore_patterns = {},
        selection_caret = "  ",
        entry_prefix = "  ",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        mappings = {
            i = {
                ["<C-f>"] = require("telescope.actions").preview_scrolling_up,
                ["<C-b>"] = require("telescope.actions").preview_scrolling_down,
            },
            n = {
                ["<C-f>"] = require("telescope.actions").preview_scrolling_up,
                ["<C-b>"] = require("telescope.actions").preview_scrolling_down,
            },
        },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        frecency = {
            show_scores = true,
            show_unindexed = true,
            ignore_patterns = { "*.git/*", "*/tmp/*" },
        },
    },
    pickers = {
        buffers = fixfolds,
        find_files = fixfolds,
        git_files = fixfolds,
        grep_string = fixfolds,
        live_grep = fixfolds,
        oldfiles = fixfolds,
    },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("project")
require("telescope").load_extension("frecency")
