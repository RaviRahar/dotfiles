---------------------------------------------------------------
-- => Transparency and Neat Errors
---------------------------------------------------------------
vim.cmd([[
    augroup Theme
    autocmd!
        autocmd VimEnter * hi! clear NonText
        autocmd VimEnter * hi! clear ModeMsg
        autocmd VimEnter * hi! clear MoreMsg
        autocmd VimEnter * hi! clear ModeArea
        autocmd VimEnter * hi! clear ErrorMsg
        autocmd VimEnter * hi! clear Error
        " autocmd VimEnter * hi! clear Directory
        autocmd VimEnter * hi! clear VertSplit
        autocmd VimEnter * hi! clear SignColumn
        autocmd VimEnter * hi! clear EndOfBuffer
        autocmd VimEnter * hi! clear Folded
        autocmd VimEnter * hi! clear Normal
        autocmd VimEnter * hi! clear LineNr
        autocmd VimEnter * hi! clear SignColumn
        autocmd VimEnter * hi! clear Cursor
        autocmd VimEnter * hi! CursorLineNr cterm=bold
        " autocmd VimEnter * hi! Visual guibg=#83a598 guifg=#222222
        " autocmd VimEnter * hi! CursorLine

        autocmd VimEnter * hi! NormalFloat guibg=none
        autocmd VimEnter * hi! WinSeparator guibg=none

    augroup end
]])

---------------------------------------------------------------
-- => Some Custom Mappings
---------------------------------------------------------------

local opts = { noremap = true, silent = true }
-- Save last session
-- Automatically save the session when leaving Vim
vim.cmd([[
    augroup SaveSessionAutomatically
        autocmd!
        autocmd! VimLeave * silent! mksession! ]] ..
    vim.fn.stdpath("state") ..
    [[/LastSession.vim]] ..
    [[

    augroup end
    ]]
)
vim.keymap.set("n", "<leader>re", ":source" .. vim.fn.stdpath("state") .. "/LastSession.vim<CR>", opts)

-- Keep cursor centered while n, N through searches
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "J", "mzJ`z", opts)

-- Keep cursor centered
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)

-- Toggle conceal
local isConcealEnabled = false
vim.keymap.set("n", "<leader>lh",
    function()
        if isConcealEnabled then
            vim.o.conceallevel = 0
        else
            vim.o.conceallevel = 3
        end
        isConcealEnabled = not isConcealEnabled
    end, opts)

-- Quickfix mappings
vim.keymap.set("n", "<leader>qt", ":copen<CR>", opts)
vim.keymap.set("n", "[q", ":cprevious<CR>", opts)
vim.keymap.set("n", "]q", ":cnext<CR>", opts)

vim.api.nvim_create_user_command("QuickFixMapping", function()
    local bufopts = { noremap = true, silent = true, buffer = 0 }
    vim.keymap.set("n", "<Esc>", ":quit<CR>", bufopts)
end, {})

vim.cmd([[
augroup QuickFixCustoms
  autocmd!
  autocmd FileType qf QuickFixMapping
augroup end
]])

----------------------------------------------------------------
-- => Below keybindings are made for netrw and terminal mode too
----------------------------------------------------------------
-- tabs
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", opts)
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", opts)
vim.keymap.set("n", "<leader>tm", ":tabmove<CR>", opts)

vim.keymap.set("n", "<leader>bo", ":only<CR>", opts)
vim.keymap.set("n", "<leader>bn", ":enew<CR>", opts)
vim.keymap.set("n", "<C-w>q", ":bdelete!<CR>", opts)
vim.keymap.set("n", "gb", ":bnext<CR>", opts)
vim.keymap.set("n", "gB", ":bprevious<CR>", opts)

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
                exe 'silent! bdelete!' join(empty)
            endif
    ]])
end, {})

vim.keymap.set("n", "<leader>bad", ":DeleteEmptyBuffers<CR>", opts)

---------------------------------------------------------------
-- => Netrw
---------------------------------------------------------------
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30
vim.g.netrw_wiw = 30
vim.g.netrw_altv = 0
vim.g.netrw_alto = 1
vim.g.netrw_altfile = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_preview = 1
vim.g.netrw_keepdir = 1
vim.g.netrw_errorlvl = 0
--open files in: 1 horizontal split, 2 vertical split, 3 new tab, 4 previous window
vim.g.netrw_browse_split = 0
-- vim.g.netrw_chgwin = 2
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro nornu"
vim.g.netrw_silent = 1

local ghregex = [[\(^\|\s\s\)\zs\.\S\+]]
vim.g.netrw_list_hide = ghregex

-- Netrw delete unnecessarily created empty buffers
vim.keymap.set("n", "<C-p>", ":Explore<CR>", opts)


vim.api.nvim_create_user_command("NetrwMapping", function()
    local bufopts = { noremap = true, silent = true, buffer = 0 }

    vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", bufopts)
    vim.keymap.set("n", "<leader>to", ":tabonly<CR>", bufopts)
    vim.keymap.set("n", "<leader>tm", ":tabmove<CR>", bufopts)
    vim.keymap.set("n", "gt", ":tabnext<CR>", bufopts)
    vim.keymap.set("n", "gT", ":tabprevious<CR>", bufopts)

    vim.keymap.set("n", "<leader>bn", ":enew<CR>", bufopts)
    vim.keymap.set("n", "<leader>bo", ":only<CR>", bufopts)
    vim.keymap.set("n", "<C-w>q", ":bdelete!<CR>", bufopts)
    vim.keymap.set("n", "gb", ":bnext<CR>", bufopts)
    vim.keymap.set("n", "gB", ":bprevious<CR>", bufopts)
    vim.keymap.set("n", "<Esc>", ":bdelete!<CR>", bufopts)
    vim.keymap.set("n", "<C-p>", ":bdelete!<CR>", bufopts)


    vim.keymap.set("n", "?", ":help netrw-quickmap<CR>", bufopts)
end, {})

-- close if final buffer is netrw or the quickfix
-- autocmd FileType netrw setl bufhidden=wipe
-- autocmd FileType quickfix setl bufhidden=wipe
-- autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
vim.cmd([[
    augroup NetrwCustoms
        autocmd!
        autocmd FileType netrw NetrwMapping
    augroup end
]])

---------------------------------------------------------------
-- => Terminal Mode and Mappings
---------------------------------------------------------------
local termopts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>tt", ":tabnew term://bash<CR>i", termopts)
vim.keymap.set("n", "<leader>tv", ":vnew term://bash<CR>i", termopts)
vim.keymap.set("n", "<leader>th", ":new term://bash<CR>i", termopts)

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], termopts)
