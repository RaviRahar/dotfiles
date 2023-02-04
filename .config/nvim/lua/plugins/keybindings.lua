--------------------------------------------------------------
-- => Keybindings
---------------------------------------------------------------
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-w>", ":bdelete!<CR>", opts)
-- Toggle tagbar
vim.keymap.set("n", "<leader><C-l>", ":TagbarToggle<CR>", opts)
vim.keymap.set("n", "<leader>L", ":UndotreeToggle<CR>", opts)
-- Markdown
vim.keymap.set("n", "<leader>md", ":Glow<CR>", opts)
vim.keymap.set("n", "<leader>mds", ":MarkdownPreview<CR>", { silent = true })
vim.keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { silent = true })
vim.keymap.set("n", "<leader>mt", ":MarkdownPreviewToggle<CR>", { silent = true })

-- Alpha (Dashboard)
vim.keymap.set("n", "<leader>nn", ":enew<CR>", opts)

-- Sniprun
vim.keymap.set("v", "<leader>r", ":SnipRun<CR>", opts)
vim.keymap.set("n", "<leader>r", ":SnipRun<CR>", opts)

-- Trouble
vim.keymap.set("n", "<leader>st", ":TroubleToggle<CR>", opts)
vim.keymap.set("n", "<leader>qf", ":Trouble quickfix<CR>", opts)

-- FzfLua
vim.keymap.set("n", "<leader>ff", ":FzfLua files cwd=" .. os.getenv("HOME") .. "<CR>", opts)
-- vim.keymap.set('n', '<leader>fw', ':FzfLua live_grep_native<CR>', opts)
-- vim.keymap.set('n', '<leader>fh', 'FzfLua oldfiles<CR>', opts)
-- vim.keymap.set('n', '<leader>fb', ':FzfLua buffers<CR>', opts)

-- vim.keymap.set('n', '<leader>gf', ':FzfLua git_files<CR>', opts)

-- Vim Fugitive Settings
vim.keymap.set("n", "<leader>gs", ":G<CR>", opts)
vim.keymap.set("n", "<leader>gab", ":G blame<CR>", opts)
vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", opts)
vim.keymap.set("n", "<leader>gf", ":G fetch --all<CR>", opts)

vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit!<CR>", opts)
vim.keymap.set("n", "<leader>gh", ":diffget //2<CR>", opts)
vim.keymap.set("n", "<leader>gl", ":diffget //3<CR>", opts)

-- Telescope Settings
vim.keymap.set("n", "<leader>ts", ":Telescope<CR>", opts)
vim.keymap.set("v", "<leader>ts", ":Telescope<CR>", opts)

vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<CR>", opts)
vim.keymap.set("n", "<leader>fh", ":Telescope find_files<CR>", opts)
vim.keymap.set("n", "<leader>fg", ":Telescope git_files<CR>", opts)
vim.keymap.set("n", "<leader>fc", ":Telescope colorscheme<CR>", opts)
vim.keymap.set("n", "<leader>fw", ":Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<leader>fm", ":Telescope marks<CR>", opts)
vim.keymap.set("n", "<leader>fr", ":Telescope frecency<CR>", opts)
vim.keymap.set("n", "<leader>fp", ":Telescope project<CR>", opts)
vim.keymap.set("n", "<leader>bb", ":Telescope buffers initial_mode=normal<CR>", opts)
vim.keymap.set("n", "<leader>aa", ":Telescope telescope-tabs list_tabs initial_mode=normal<CR>", opts)

vim.keymap.set("n", "<leader>mp", ":Telescope man_pages<CR>", opts)
vim.keymap.set("n", "<leader>cmd", ":Telescope commands<CR>", opts)

--vim.keymap.set('n', '<leader>gs', ':Telescope git_status<CR>', opts)
-- vim.keymap.set('n', '<leader>gc', ':Telescope git_branches<CR>', opts)
-- vim.keymap.set('n', '<leader>gl', ':Telescope git_commits<CR>', opts)
-- vim.keymap.set('n', '<leader>gll', ':Telescope git_bcommits<CR>', opts)
--vim.keymap.set('n', '<leader>ga', ':Telescope git_stash<CR>', opts)

-- Custom Keybindings
vim.cmd([[
    augroup CustomKeybindings
    autocmd!

    autocmd FileType html nnoremap <buffer> <silent> <leader>sl :! browser-sync start --server --files "*.js, *.html, *.css" &; firefox-developer-edition localhost:3000/%:p & <CR>
    augroup end
]])
