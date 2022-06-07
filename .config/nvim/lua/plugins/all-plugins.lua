---------------------------------------------------------------
-- => Colors and Theming
---------------------------------------------------------------
--vim.g.airline_powerline_fonts = 1
vim.g.gruvbox_contrast_dark = 'soft'
vim.g.gruvbox_transparent_bg = 1
vim.g.gruvbox_termcolors = 256
vim.g.rehash256 = 1
vim.api.nvim_exec([[colorscheme gruvbox]], false)


vim.api.nvim_exec([[
    augroup Theme
    autocmd!
    autocmd VimEnter * hi Normal ctermbg=none guibg=none
    autocmd VimEnter * hi LineNr ctermbg=none guibg=none
    autocmd VimEnter * hi SignColumn ctermbg=none guibg=none
    autocmd VimEnter * hi CursorLine ctermbg=none guibg=none

    autocmd VimEnter * hi GruvboxGreenSign ctermbg=none guibg=none
    autocmd VimEnter * hi GruvboxAquaSign ctermbg=none guibg=none
    autocmd VimEnter * hi GruvboxRedSign ctermbg=none guibg=none
    autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    augroup end
]], false)

---------------------------------------------------------------
-- => Tagbar
---------------------------------------------------------------
-- Toggle tagbar
vim.api.nvim_set_keymap('n', "<leader>'", ':TagbarToggle<CR>', { noremap = true, silent = true })

---------------------------------------------------------------
-- => Vimtex
---------------------------------------------------------------
--vim.g.vimtex_view_method = 'firefox'
--vim.g.vimtex_view_general_viewer = 'firefox'
--vim.g.vimtex_view_general_options = 'file:@pdf\#src:@line@tex'

---------------------------------------------------------------
-- => Markdown Plugins
---------------------------------------------------------------
-- Glow
vim.g.glow_style = 'dark'
vim.g.glow_binary_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/'
-- Markdown-Preview
vim.api.nvim_set_keymap('n', '<leader>md', ':Glow<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>mds', '<Plug>MarkdownPreview', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>ms', '<Plug>MarkdownPreviewStop', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>mt', '<Plug>MarkdownPreviewToggle', { silent = true })

---------------------------------------------------------------
-- => File-Type Plugin
---------------------------------------------------------------
require('filetype').setup({
  overrides = {
    shebang = {
      -- Set the filetype of files with a dash shebang to sh
      dash = 'sh',
    },
  },
})
