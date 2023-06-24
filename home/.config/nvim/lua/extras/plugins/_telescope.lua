---------------------------------------------------------------
-- => Telescope Settings
---------------------------------------------------------------
return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        cmd = "Telescope",
        dependencies = {
            { "nvim-lua/plenary.nvim",                      lazy = true },
            { "nvim-telescope/telescope-fzf-native.nvim",   build = "make", lazy = true },
            { "nvim-telescope/telescope-project.nvim",      lazy = true },
            { "nvim-telescope/telescope-frecency.nvim",     lazy = true,    dependencies = { "tami5/sqlite.lua" } },
            { "LukasPietzschmann/telescope-tabs",           lazy = true },
            { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
        },
        config = function()
            vim.cmd([[
                hi! TelescopeTitle cterm=bold gui=bold guifg=#000000 guibg=#83a598
            ]])
            local fb_actions = require "telescope".extensions.file_browser.actions
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
                            width = 0.85,
                            height = 0.80,
                            preview_cutoff = 40,
                            prompt_position = "bottom",
                            preview_width = 0.55,
                            -- results_width = 0.8,
                        },
                        vertical = {
                            width = 0.8,
                            height = 0.9,
                            preview_cutoff = 40,
                            prompt_position = "bottom",
                            mirror = false,
                        },
                    },
                    mappings = {
                        i = {
                            ["<C-f>"] = require("telescope.actions").preview_scrolling_up,
                            ["<C-b>"] = require("telescope.actions").preview_scrolling_down,
                            ["<C-w>"] = require("telescope.actions").delete_buffer,
                            ["<leader>h"] = require("telescope.actions").delete_buffer,
                        },
                        n = {
                            ["<C-f>"] = require("telescope.actions").preview_scrolling_up,
                            ["<C-b>"] = require("telescope.actions").preview_scrolling_down,
                            ["<C-h>"] = require("telescope.actions").select_horizontal,
                            ["<C-w>"] = require("telescope.actions").delete_buffer,
                            ["<leader>h"] = require("telescope.actions").delete_buffer,
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
                    file_browser = {
                        hidden = true,
                        -- hijack_netrw = true,
                        grouped = true,
                        select_buffer = true,
                        sorting_strategy = "ascending",
                        initial_mode = "normal",
                        default_selection_index = 2,
                        mappings = {
                            i = {
                                ["<C-h>"] = fb_actions.goto_parent_dir,
                                -- ["<C-l>"] = fb_actions.select_default,
                                ["<C-H>"] = fb_actions.toggle_hidden,

                            },
                            n = {
                                ["h"] = fb_actions.goto_parent_dir,
                                -- ["l"] = fb_actions.select_default,
                                ["H"] = fb_actions.toggle_hidden,
                            }
                        },
                    },
                },
                pickers = {
                    buffers = fixfolds,
                    find_files = fixfolds,
                    git_files = fixfolds,
                    grep_string = fixfolds,
                    live_grep = fixfolds,
                    oldfiles = fixfolds,
                    man_pages = {
                        sections = { "ALL" },
                    },
                },
            })

            vim.cmd([[
            augroup Telescope
                autocmd!
                autocmd FileType TelescopePrompt nnoremap <buffer> <silent> p i<C-r>"<Esc>
            augroup end
            ]])

            require("telescope").load_extension("fzf")
            require("telescope").load_extension("project")
            require("telescope").load_extension("frecency")
            require("telescope").load_extension("file_browser")
            require("telescope-tabs").setup({
                show_preview = true,
                close_tab_shortcut_i = "<leader>h",
                close_tab_shortcut_n = "<leader>h",
            })
        end,
    },
}
