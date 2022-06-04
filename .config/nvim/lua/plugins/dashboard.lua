---------------------------------------------------------------
-- => Dashboard
---------------------------------------------------------------

vim.g.dashboard_custom_header = {
    [[                               ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡖⠁⠀⠀⠀⠀⠀⠀⠈⢲⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⣼⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣧⠀⠀⠀⠀⠀⠀⠀⠀ ]],
    [[⠀⠀⠀⠀⠀⠀⠀⣸⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣇⠀⠀⠀⠀⠀⠀⠀ ]],
    [[⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⢀⣀⣤⣤⣤⣤⣀⡀⠀⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀ ]],
    [[⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣔⢿⡿⠟⠛⠛⠻⢿⡿⣢⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀ ]],
    [[⠀⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣷⣤⣀⡀⢀⣀⣤⣾⣿⣿⣿⣷⣶⣤⡀⠀⠀⠀⠀ ]],
    [[⠀⠀⢠⣾⣿⡿⠿⠿⠿⣿⣿⣿⣿⡿⠏⠻⢿⣿⣿⣿⣿⠿⠿⠿⢿⣿⣷⡀⠀⠀ ]],
    [[⠀⢠⡿⠋⠁⠀⠀⢸⣿⡇⠉⠻⣿⠇⠀⠀⠸⣿⡿⠋⢰⣿⡇⠀⠀⠈⠙⢿⡄⠀ ]],
    [[⠀⡿⠁⠀⠀⠀⠀⠘⣿⣷⡀⠀⠰⣿⣶⣶⣿⡎⠀⢀⣾⣿⠇⠀⠀⠀⠀⠈⢿⠀ ]],
    [[⠀⡇⠀⠀⠀⠀⠀⠀⠹⣿⣷⣄⠀⣿⣿⣿⣿⠀⣠⣾⣿⠏⠀⠀⠀⠀⠀⠀⢸⠀ ]],
    [[⠀⠁⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⢇⣿⣿⣿⣿⡸⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠈⠀ ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
    [[⠀⠀⠀⠐⢤⣀⣀⢀⣀⣠⣴⣿⣿⠿⠋⠙⠿⣿⣿⣦⣄⣀⠀⠀⣀⡠⠂⠀⠀⠀ ]],
    [[⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠉⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠋⠁⠀⠀⠀⠀⠀ ]],
    [[                               ]],
  }


vim.api.nvim_set_keymap('n', '<leader>ds', ':<C-u>SessionSave<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dl', ':<C-u>SessionLoad<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nn', ':tabnew<CR>', { noremap = true, silent = true })

vim.g.dashboard_default_executive ='telescope'
vim.g.indentLine_fileTypeExclude = 'dashboard'
vim.g.dashboard_custom_shortcut={
 ['last_session']       = '<leader> d l',
 ['find_history']       = '<leader> f h',
 ['find_file']          = '<leader> f f',
 ['change_colorscheme'] = '<leader> f c',
 ['find_word']          = '<leader> f w',
 ['book_marks']         = '<leader> f m',
 ['new_file']           = '<leader> n n',
}

vim.g.hidden_all = 0
vim.api.nvim_create_user_command(
  'ToggleHiddenAll',
  function()
    if vim.g.hidden_all  == 0 then
        vim.g.hidden_all = 1
        vim.opt.showmode = false
        vim.opt.ruler = false
        vim.opt.laststatus = 0
        vim.opt.showcmd = false
    else
        vim.g.hidden_all = 0
        vim.opt.showmode = true
        vim.opt.ruler = true
        vim.opt.laststatus = 2
        vim.opt.showcmd = true
    end
  end,
  {}
)

vim.api.nvim_set_keymap('n', '<S-h>', 'ToggleHiddenAll', { noremap = true, silent = true })

vim.api.nvim_exec([[
augroup HideAll
  autocmd!
  autocmd FileType dashboard nnoremap <buffer> <silent> <leader>nn :DashboardNewFile<CR>
  autocmd FileType dashboard :ToggleHiddenAll
  autocmd FileType dashboard :autocmd! WinLeave <buffer> :ToggleHiddenAll
augroup end
]], false)
