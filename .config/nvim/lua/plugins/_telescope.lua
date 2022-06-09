---------------------------------------------------------------
-- => Telescope Settings
---------------------------------------------------------------
vim.cmd([[packadd sqlite.lua]])
vim.cmd([[packadd telescope-fzf-native.nvim]])
vim.cmd([[packadd telescope-project.nvim]])
vim.cmd([[packadd telescope-frecency.nvim]])
-- vim.cmd([[packadd telescope-zoxide]])

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

require('telescope').setup{
  defaults = {
      content_spec_column = false,
      initial_mode = "insert",
      prompt_prefix = "  ",
      selection_caret = " ",
      entry_prefix = " ",
      scroll_strategy = "limit",
      results_title = false,
      --borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      layout_strategy = "horizontal",
      path_display = { "absolute" },
      file_ignore_patterns = {},
      layout_config = {
        prompt_position = "bottom",
        horizontal = {
          preview_width = 0.5,
        },
      },
      mappings = {
        i = {
          ["<C-f>"] = require('telescope.actions').preview_scrolling_up,
          ["<C-b>"] = require('telescope.actions').preview_scrolling_down,
        },
        n = {
          ["<C-f>"] = require('telescope.actions').preview_scrolling_up,
          ["<C-b>"] = require('telescope.actions').preview_scrolling_down,
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
        fuzzy = false,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      frecency = {
        show_scores = false,
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
}

require("telescope").load_extension("fzf")
require("telescope").load_extension("project")
-- require("telescope").load_extension("zoxide")
require("telescope").load_extension("frecency")
