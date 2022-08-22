---------------------------------------------------------------
-- => Transparency
---------------------------------------------------------------
--vim.api.nvim_exec([[
--    augroup Theme
--    autocmd!
--    autocmd VimEnter * hi Normal ctermbg=none guibg=none
--    autocmd VimEnter * hi LineNr ctermbg=none guibg=none
--    autocmd VimEnter * hi SignColumn ctermbg=none guibg=none
--    autocmd VimEnter * hi CursorLine ctermbg=none guibg=none
--    augroup end
--]], false)

---------------------------------------------------------------
-- => AutomaticPairing
---------------------------------------------------------------

vim.api.nvim_set_keymap('i', '"', '""<left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', "'", "''<left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '(', '()<left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '[', '[]<left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<', '<><left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '{', '{}<left>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('i', '{<CR>', '{<CR>}<ESC>O', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('i', '{;<CR>', '{<CR>};<ESC>O', { noremap = true, silent = true })

-- skip bracket if it is a closing one instead of creating new
vim.api.nvim_set_keymap('i', '"', [[strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"]], { noremap = true, silent = true, expr=true })
vim.api.nvim_set_keymap('i', "'", [[strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"]], { noremap = true, silent = true, expr=true })
vim.api.nvim_set_keymap('i', ')', [[strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"]], { noremap = true, silent = true, expr=true })
vim.api.nvim_set_keymap('i', ']', [[strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"]], { noremap = true, silent = true, expr=true })
vim.api.nvim_set_keymap('i', '>', [[strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"]], { noremap = true, silent = true, expr=true })
vim.api.nvim_set_keymap('i', '}', [[strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"]], { noremap = true, silent = true, expr=true })

---------------------------------------------------------------
-- => Netrw
---------------------------------------------------------------
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_altv = 1
vim.g.netrw_alto = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_preview = 1
--vim.g.netrw_keepdir= 0
vim.g.netrw_errorlvl = 2
--open files in: 1 horizontal split, 2 vertical split, 3 new tab, 4 previous window
vim.g.netrw_browse_split = 3

local ghregex = [[\(^\|\s\s\)\zs\.\S\+]]
vim.g.netrw_list_hide = ghregex

vim.api.nvim_set_keymap('n', '<leader>l', ':Lexplore<CR>', { noremap = true, silent = true })


vim.api.nvim_create_user_command(
  'NetrwMapping',
  function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
  end,
  {}
)

-- close if final buffer is netrw or the quickfix
vim.api.nvim_exec([[
augroup NetrwCustoms
  autocmd!
  autocmd FileType netrw NetrwMapping
  autocmd FileType netrw setl bufhidden=wipe
  autocmd BufEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
augroup end
]], false)

---------------------------------------------------------------
-- => Text, scroll, backspace, tab and indent related
---------------------------------------------------------------
-- Set specific indentation for some filetypes

vim.api.nvim_exec([[
augroup FileRelated
 autocmd!
 autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup end
]], false)

-- Keep cursor centered while n, N through searches
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'J', 'mzJ`z', { noremap = true, silent = true })

---------------------------------------------------------------
-- => Remap Keys and Some functionalities
---------------------------------------------------------------
-- Remap ESC to jk
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })
-- Make Y(capital y) behave how C behaves
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'qw', ':nohl<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-e>', '<C-o>A', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-a>', '<C-o>_', { noremap = true, silent = true })
-- tabs
vim.api.nvim_set_keymap('n', '<leader>to', ':tabonly<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })
-- windows (splits)
vim.api.nvim_set_keymap('n', '<leader>bo', ':only<CR>', { noremap = true, silent = true })
-- buffer
vim.api.nvim_set_keymap('n', '<leader>bn', ':enew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true, silent = true })

---------------------------------------------------------------
-- => Open terminal inside Vim
---------------------------------------------------------------
vim.api.nvim_set_keymap('n', '<leader>tt', ':tabnew term://bash<CR>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tv', ':vnew term://bash<CR>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>th', ':new term://bash<CR>i', { noremap = true, silent = true })

---------------------------------------------------------------
-- => Splits and Tabbed Files
---------------------------------------------------------------
-- Remap splits navigation to just CTRL + hjkl
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Make adjusing split sizes a bit more friendly
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize +3<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize -3<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize +3<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize -3<CR>', { noremap = true, silent = true })

-- Change 2 split windows from vert to horiz or horiz to vert
vim.api.nvim_set_keymap('n', '<leader>sh', '<C-w>t<C-w>H', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sv', '<C-w>t<C-w>K', { noremap = true, silent = true })

---------------------------------------------------------------
-- => Undo Breakpoints
---------------------------------------------------------------
vim.api.nvim_set_keymap('i', ',', ',<c-g>U', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '.', '.<c-g>U', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '!', '!<c-g>U', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '?', '?<c-g>U', { noremap = true, silent = true })

---------------------------------------------------------------
-- => Moving Text
---------------------------------------------------------------
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-j>', '<esc>:m .+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<esc>:m .-2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', ':m .+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':m .-2<CR>==e', { noremap = true, silent = true })
