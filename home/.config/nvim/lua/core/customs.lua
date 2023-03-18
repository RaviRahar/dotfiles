---------------------------------------------------------------
-- => Transparency
---------------------------------------------------------------
vim.cmd([[
    augroup Theme
    autocmd!
    autocmd VimEnter * hi Normal ctermbg=none guibg=none
    autocmd VimEnter * hi LineNr ctermbg=none guibg=none
    autocmd VimEnter * hi SignColumn ctermbg=none guibg=none
    autocmd VimEnter * hi CursorLine ctermbg=none guibg=none
    augroup end
]])

---------------------------------------------------------------
-- => AutomaticPairing
---------------------------------------------------------------
local opts = { noremap = true, silent = true }

vim.keymap.set("i", "()", "()<left>", opts)
vim.keymap.set("i", "{}", "{}<left>", opts)
vim.keymap.set("i", "[]", "[]<left>", opts)

vim.keymap.set("i", "{}<CR>", "{}<left><CR><Esc>O", opts)
-- vim.keymap.set('i', '<>', '<><left>', opts)
-- vim.keymap.set('i', '{<CR>', '{<CR>}<ESC>O', opts)
-- vim.keymap.set('i', '{;<CR>', '{<CR>};<ESC>O', opts)

-- skip bracket if it is a closing one instead of creating new
vim.keymap.set(
    "i",
    ")",
    [[strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"]],
    { noremap = true, silent = true, expr = true, replace_keycodes = false }
)
vim.keymap.set(
    "i",
    "}",
    [[strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"]],
    { noremap = true, silent = true, expr = true, replace_keycodes = false }
)
vim.keymap.set(
    "i",
    "]",
    [[strpart(getline('.'), col('.')-1, 1) == "]" ? "<Right>" : "]"]],
    { noremap = true, silent = true, expr = true, replace_keycodes = false }
)
-- vim.keymap.set(
--     "i",
--     ">",
--     [[strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"]],
--     { noremap = true, silent = true, expr = true, replace_keycodes = false }
-- )

---------------------------------------------------------------
-- => Netrw
---------------------------------------------------------------
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30
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

vim.keymap.set("n", "<leader>l", ":Lexplore<CR>", opts)

vim.api.nvim_create_user_command("NetrwMapping", function()
    vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, buffer = 0 })
    vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, buffer = 0 })
    vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, buffer = 0 })
    vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, buffer = 0 })

    vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>tn", ":tabnew<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>tm", ":tabmove<CR>", { noremap = true, silent = true })

    vim.api.nvim_set_keymap("n", "<leader>bo", ":only<CR>", { noremap = true, silent = true })

    vim.api.nvim_set_keymap("n", "<leader>bn", ":enew<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>bd", ":bdelete!<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>h", ":bdelete!<CR>", { noremap = true, silent = true })

    vim.keymap.set("n", "?", ":help netrw-quickmap<CR>", { noremap = true, silent = true, buffer = 0 })
end, {})

-- close if final buffer is netrw or the quickfix
vim.cmd([[
augroup NetrwCustoms
  autocmd!
  autocmd FileType netrw NetrwMapping
  autocmd FileType netrw setl bufhidden=wipe
  autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
augroup end
]])

---------------------------------------------------------------
-- => Text, scroll, backspace, tab and indent related
---------------------------------------------------------------
-- Set specific indentation for some filetypes

vim.cmd([[
augroup FileRelated
  autocmd!
  autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd FileType sh,bash setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd FileType javascript,css setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup end
]])

-- Keep cursor centered while n, N through searches
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "J", "mzJ`z", opts)

-- Keep cursor centered
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)

---------------------------------------------------------------
-- => Remap Keys and Some functionalities
---------------------------------------------------------------
-- Remap ESC to jk
vim.keymap.set("i", "jk", "<C-O>:stopinsert<CR>", opts)
vim.keymap.set("v", "p", '"_dp', opts)
vim.keymap.set("v", "P", '"_dP', opts)

vim.keymap.set("n", "<leader>p", '"+p', opts)
vim.keymap.set("v", "<leader>p", '"_d"+p', opts)
vim.keymap.set("n", "<leader>P", '"+P', opts)
vim.keymap.set("v", "<leader>P", '"_d"+P', opts)

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', opts)

vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', opts)
vim.keymap.set({ "n", "v" }, "<leader>D", '"+D', opts)

vim.keymap.set({ "n", "v" }, "d", '"_d', opts)
vim.keymap.set({ "n", "v" }, "D", '"_D', opts)

vim.keymap.set({ "n", "v" }, "x", '"_x', opts)
vim.keymap.set({ "n", "v" }, "X", '"_X', opts)

-- Make Y(capital y) behave how C behaves
vim.keymap.set("n", "Y", "y$", opts)
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", opts)
vim.keymap.set("i", "<C-e>", "<C-o>A", opts)
vim.keymap.set("i", "<C-a>", "<C-o>_", opts)
-- tabs
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", opts)
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", opts)
vim.keymap.set("n", "<leader>tm", ":tabmove<CR>", opts)
-- windows (splits)
vim.keymap.set("n", "<leader>bo", ":only<CR>", opts)
-- buffer
vim.keymap.set("n", "<leader>bn", ":enew<CR>", opts)
vim.keymap.set("n", "gb", ":bnext<CR>", opts)
vim.keymap.set("n", "gB", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>bd", ":bdelete!<CR>", opts)
vim.keymap.set("n", "<leader>h", ":bdelete!<CR>", opts)

vim.api.nvim_create_user_command("DeleteEmptyBuffers", function()
    vim.cmd([[
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
    ]])
end, {})

vim.keymap.set("n", "<leader>bad", ":DeleteEmptyBuffers<CR>", opts)

---------------------------------------------------------------
-- => Terminal Mode and Mappings
---------------------------------------------------------------
vim.keymap.set("n", "<leader>tt", ":tabnew term://bash<CR>i", opts)
vim.keymap.set("n", "<leader>tv", ":vnew term://bash<CR>i", opts)
vim.keymap.set("n", "<leader>th", ":new term://bash<CR>i", opts)

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
vim.api.nvim_set_keymap("t", "gB", [[<C-\><C-n>:bprevious<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader>bd", [[<C-\><C-n>:bdelete!<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader>h", [[<C-\><C-n>:bdelete!<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-w>", [[<C-\><C-n>:bdelete!<CR>]], { noremap = true, silent = true })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)

---------------------------------------------------------------
-- => Splits and Tabbed Files
---------------------------------------------------------------
-- Remap splits navigation to just CTRL + hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Make adjusing split sizes a bit more friendly
vim.keymap.set("n", "<C-Left>", ":vertical resize +3<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize -3<CR>", opts)
vim.keymap.set("n", "<C-Up>", ":resize +3<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize -3<CR>", opts)

-- Change 2 split windows from vert to horiz or horiz to vert
vim.keymap.set("n", "<leader>sh", "<C-w>t<C-w>K<C-w>=", opts)
vim.keymap.set("n", "<leader>sv", "<C-w>t<C-w>H<C-w>=", opts)

---------------------------------------------------------------
-- => Undo Breakpoints
---------------------------------------------------------------
vim.keymap.set("i", ",", ",<c-g>U", opts)
vim.keymap.set("i", ".", ".<c-g>U", opts)
vim.keymap.set("i", "!", "!<c-g>U", opts)
vim.keymap.set("i", "?", "?<c-g>U", opts)

---------------------------------------------------------------
-- => Moving Text
---------------------------------------------------------------
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("i", "<C-j>", "<esc>:m .+1<CR>==i", opts)
vim.keymap.set("i", "<C-k>", "<esc>:m .-2<CR>==i", opts)
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==", opts)
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==", opts)

---------------------------------------------------------------
-- => Lsp Related
---------------------------------------------------------------
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
