---------------------------------------------------------------
-- => Keybindings
---------------------------------------------------------------
-- Toggle tagbar
vim.api.nvim_set_keymap('n', "<leader>'", ':TagbarToggle<CR>', { noremap = true, silent = true })

-- Markdown
vim.api.nvim_set_keymap('n', '<leader>md', ':Glow<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>mds', '<Plug>MarkdownPreview', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>ms', '<Plug>MarkdownPreviewStop', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>mt', '<Plug>MarkdownPreviewToggle', { silent = true })

-- Alpha (Dashboard)
vim.api.nvim_set_keymap('n', '<leader>nn', ':tabnew<CR>', { noremap = true, silent = true })

-- Sniprun
vim.api.nvim_set_keymap('v', '<leader>r', '<Plug>SnipRun<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>r', '<Plug>SnipRunOperator<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>rr', '<Plug>SnipRun<CR>', {noremap = true, silent = true})

-- Trouble
vim.api.nvim_set_keymap('n', '<leader>st', ':TroubleToggle<CR>', { noremap = true, silent = true })

-- FzfLua
vim.api.nvim_set_keymap('n', '<leader>ff', ':FzfLua files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fw', ':FzfLua live_grep_native', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fh', 'FzfLua oldfiles<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fb', ':FzfLua buffers<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>gf', ':FzfLua git_files', { noremap = true, silent = true })

-- Vim Fugitive Settings
vim.api.nvim_set_keymap('n', '<leader>gs', ':G<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ga', ':Git fetch --all<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>gh', ':diffget //3<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gu', ':diffget //2<CR>', { noremap = true, silent = true })

-- Telescope Settings
vim.api.nvim_set_keymap('n', '<leader>ts', ':Telescope<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>ts', ':Telescope<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope oldfiles<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fc', ':Telescope colorscheme<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fw', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fm', ':Telescope marks<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fr', ':Telescope frecency<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fp', ':Telescope project<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>mp', ':Telescope man_pages<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cmd', ':Telescope commands<CR>', { noremap = true, silent = true })

--vim.api.nvim_set_keymap('n', '<leader>gs', ':Telescope git_status<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gc', ':Telescope git_branches<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gl', ':Telescope git_commits<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gll', ':Telescope git_bcommits<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>ga', ':Telescope git_stash<CR>', { noremap = true, silent = true })
