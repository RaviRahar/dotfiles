---------------------------------------------------------------
-- => Vim Fugitive Settings
---------------------------------------------------------------

--vim.api.nvim_set_keymap('n', '<leader>gs', ':G<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ga', ':Git fetch --all<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>gh', ':diffget //3<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gu', ':diffget //2<CR>', { noremap = true, silent = true })

---------------------------------------------------------------
-- => Vim GitGutter Settings
---------------------------------------------------------------
vim.api.nvim_set_keymap('n', ']h', '<Plug>(GitGutterNextHunk)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[h', '<Plug>(GitGutterPrevHunk)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ghs', '<Plug>(GitGutterStageHunk)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ghu', '<Plug>(GitGutterUndoHunk)', { noremap = true, silent = true })

vim.g.gitgutter_sign_added = '✚'
vim.g.gitgutter_sign_modified = '✹'
vim.g.gitgutter_sign_removed = '-'
vim.g.gitgutter_sign_removed_first_line = '-'
vim.g.gitgutter_sign_modified_removed = '-'

-- Telescope shotcuts
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope oldfiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fc', ':Telescope colorscheme<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fw', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fm', ':Telescope marks<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>gs', ':Telescope git_status<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gc', ':Telescope git_branches<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gl', ':Telescope git_commits<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gll', ':Telescope git_bcommits<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ga', ':Telescope git_stash<CR>', { noremap = true, silent = true })
