"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Telescope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
"nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
"nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
"nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <leader>fp <cmd>lua require('telescope').extensions.project.project{}<cr>
nnoremap <leader>fr <cmd>lua require('telescope').extensions.frecency.frecency{}<cr>
nnoremap <leader>fe <cmd>lua DashboardFindHistory<cr>
nnoremap <leader>ff <cmd>lua DashboardFindFile<cr>
nnoremap <leader>sc <cmd>lua DashboardChangeColorscheme<cr>
nnoremap <leader>fw <cmd>lua DashboardFindWord<cr>
nnoremap <leader>fn <cmd>lua DashboardNewFile<cr>
nnoremap <leader>fb <cmd>lua Telescope file_browser<cr>
nnoremap <leader>fg <cmd>lua Telescope git_files<cr>
nnoremap <leader>fz <cmd>lua Telescope zoxide list<cr>

lua <<EOF
require("telescope").setup({
  defaults = {
    initial_mode = "insert",
    prompt_prefix = "  ",
    selection_caret = " ",
    entry_prefix = " ",
    scroll_strategy = "limit",
    results_title = false,
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    layout_strategy = "horizontal",
    path_display = { "absolute" },
    file_ignore_patterns = {},
    layout_config = {
      prompt_position = "bottom",
      horizontal = {
        preview_width = 0.5,
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
      show_scores = true,
      show_unindexed = true,
      ignore_patterns = { "*.git/*", "*/tmp/*" },
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("project")
require("telescope").load_extension("zoxide")
require("telescope").load_extension("frecency")
EOF
