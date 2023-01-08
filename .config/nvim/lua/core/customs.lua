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

vim.api.nvim_set_keymap("i", "()", "()<left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "{}", "{}<left>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '[]', '[]<left>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<>', '<><left>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '{<CR>', '{<CR>}<ESC>O', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '{;<CR>', '{<CR>};<ESC>O', { noremap = true, silent = true })

-- skip bracket if it is a closing one instead of creating new
vim.api.nvim_set_keymap(
    "i",
    ")",
    [[strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"]],
    { noremap = true, silent = true, expr = true }
)
vim.api.nvim_set_keymap(
    "i",
    "}",
    [[strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"]],
    { noremap = true, silent = true, expr = true }
)
-- vim.api.nvim_set_keymap('i', ']', [[strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"]], { noremap = true, silent = true, expr=true })
-- vim.api.nvim_set_keymap('i', '>', [[strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"]], { noremap = true, silent = true, expr=true })

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
vim.g.netrw_browse_split = 0

local ghregex = [[\(^\|\s\s\)\zs\.\S\+]]
vim.g.netrw_list_hide = ghregex

vim.api.nvim_set_keymap("n", "<leader>l", ":Lexplore<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("NetrwMapping", function()
    vim.api.nvim_buf_set_keymap(0, "n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
end, {})

-- close if final buffer is netrw or the quickfix
vim.api.nvim_exec(
    [[
augroup NetrwCustoms
  autocmd!
  autocmd FileType netrw NetrwMapping
  autocmd FileType netrw setl bufhidden=wipe
  autocmd BufEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
augroup end
]],
    false
)

---------------------------------------------------------------
-- => Text, scroll, backspace, tab and indent related
---------------------------------------------------------------
-- Set specific indentation for some filetypes

vim.api.nvim_exec(
    [[
augroup FileRelated
 autocmd!
 autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
 autocmd InsertEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup end
]],
    false
)

-- Keep cursor centered while n, N through searches
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "J", "mzJ`z", { noremap = true, silent = true })

-- Keep cursor centered
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

---------------------------------------------------------------
-- => Remap Keys and Some functionalities
---------------------------------------------------------------
-- Remap ESC to jk
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "p", '"_dp', { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "P", '"_dP', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>p", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<leader>p", '"_d"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>P", '"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<leader>P", '"_d"+P', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Y", '"+Y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>Y", '"+Y', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>d", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>d", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>D", '"_D', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>D", '"_D', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "x", '"_x', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "x", '"_x', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "X", '"_X', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "X", '"_X', { noremap = true, silent = true })

-- Make Y(capital y) behave how C behaves
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>nh", ":nohl<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-e>", "<C-o>A", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-a>", "<C-o>_", { noremap = true, silent = true })
-- tabs
vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tn", ":tabnew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tm", ":tabmove<CR>", { noremap = true, silent = true })
-- windows (splits)
vim.api.nvim_set_keymap("n", "<leader>bo", ":only<CR>", { noremap = true, silent = true })
-- buffer
vim.api.nvim_set_keymap("n", "<leader>bn", ":enew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gb", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gB", ":bprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bd", ":bdelete!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>h", ":bdelete!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-w>", ":bdelete!<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("DeleteEmptyBuffers", function()
    vim.api.nvim_exec(
        [[
            let [i, n; empty] = [1, bufnr('$')]
            while i <= n
                if bufexists(i) && bufname(i) == ''
                    call add(empty, i)
                endif
                let i += 1
            endwhile
            if len(empty) > 0
                exe 'bdelete!' join(empty)
            endif
    ]],
        false
    )
end, {})

vim.api.nvim_set_keymap("n", "<leader>bad", ":DeleteEmptyBuffers<CR>", { noremap = true, silent = true })

---------------------------------------------------------------
-- => Terminal Mode and Mappings
---------------------------------------------------------------
vim.api.nvim_set_keymap("n", "<leader>tt", ":tabnew term://bash<CR>i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tv", ":vnew term://bash<CR>i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>th", ":new term://bash<CR>i", { noremap = true, silent = true })

vim.api.nvim_set_keymap("t", "<C-h>", [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-j>", [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-k>", [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-l>", [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })

vim.api.nvim_set_keymap("t", "<leader>to", [[<C-\><C-n>:tabonly<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader>tn", [[<C-\><C-n>:tabnew<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader>tm", [[<C-\><C-n>:tabmove<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap("t", "<leader>bo", [[<C-\><C-n>:only<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap("t", "<leader>bn", [[<C-\><C-n>:enew<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "gb", [[<C-\><C-n>:bnext<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "gB", [[<C-\><C-n>:bprevios<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader>bd", [[<C-\><C-n>:bdelete!<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader>h", [[<C-\><C-n>:bdelete!<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-w>", [[<C-\><C-n>:bdelete!<CR>]], { noremap = true, silent = true })

---------------------------------------------------------------
-- => Splits and Tabbed Files
---------------------------------------------------------------
-- Remap splits navigation to just CTRL + hjkl
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Make adjusing split sizes a bit more friendly
vim.api.nvim_set_keymap("n", "<C-Left>", ":vertical resize +3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Right>", ":vertical resize -3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Up>", ":resize +3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Down>", ":resize -3<CR>", { noremap = true, silent = true })

-- Change 2 split windows from vert to horiz or horiz to vert
vim.api.nvim_set_keymap("n", "<leader>sh", "<C-w>t<C-w>K<C-w>=", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sv", "<C-w>t<C-w>H<C-w>=", { noremap = true, silent = true })

---------------------------------------------------------------
-- => Undo Breakpoints
---------------------------------------------------------------
vim.api.nvim_set_keymap("i", ",", ",<c-g>U", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", ".", ".<c-g>U", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "!", "!<c-g>U", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "?", "?<c-g>U", { noremap = true, silent = true })

---------------------------------------------------------------
-- => Moving Text
---------------------------------------------------------------
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<esc>:m .+1<CR>==i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<esc>:m .-2<CR>==i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>j", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>k", ":m .-2<CR>==", { noremap = true, silent = true })
