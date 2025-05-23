--------------------------------------------------------------
-- => Keybindings
---------------------------------------------------------------
local opts = { noremap = true, silent = true }
vim.cmd([[
    augroup CompatibilityKeybindings
    autocmd!

    autocmd FileType undotree nnoremap <buffer> <silent> <Esc> :UndotreeToggle<CR>
    autocmd FileType diff nnoremap <buffer> <silent> <Esc> :UndotreeToggle<CR>
    autocmd FileType tagbar nnoremap <buffer> <silent> <Esc> :TagbarToggle<CR>
    autocmd FileType fzf nnoremap <buffer> <silent> <Esc> :quit!<CR>
    autocmd FileType fzf tnoremap <expr> <C-r> getreg(nr2char(getchar()))
    autocmd FileType fugitiveblame nnoremap <buffer> <silent> <Esc> :quit!<CR>
    autocmd FileType fugitive nnoremap <buffer> <silent> <Esc> :quit!<CR>

    autocmd FileType lazy nnoremap <buffer> <silent> <leader>af :quit!<CR>
    autocmd FileType mason nnoremap <buffer> <silent> <leader>ag :quit!<CR>

    augroup end
]])

-- Toggle tagbar
vim.keymap.set("n", "<leader>as", ":TagbarToggle<CR>", opts)
vim.keymap.set("n", "<leader>ad", ":UndotreeToggle<CR>", opts)
-- Markdown
vim.keymap.set("n", "<leader>md", ":MarkdownPreviewToggle<CR>", { silent = true, buffer = true })

-- Sniprun
vim.keymap.set("v", "<leader>rr", ":SnipRun<CR>", opts)
vim.keymap.set("n", "<leader>rr", ":SnipRun<CR>", opts)

-- Vim Fugitive Settings
vim.keymap.set("n", "<leader>gg", ":G<CR>", opts)
vim.keymap.set("n", "<leader>gab", ":G blame<CR>", opts)
vim.keymap.set("n", "<leader>gb", ":0, 3G blame<CR>", opts)
vim.keymap.set("n", "<leader>gf", ":G fetch --all<CR>", opts)

vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit!<CR>", opts)
vim.keymap.set("n", "<leader>gh", ":diffget //2<CR>", opts)
vim.keymap.set("n", "<leader>gl", ":diffget //3<CR>", opts)

-- Fzf Settings
vim.keymap.set("n", "<leader>fp", ":FzfCombiMode<CR>", opts)
vim.keymap.set("n", "<leader>ff", ":FzfCombiMode mode=files<CR>", opts)
vim.keymap.set("n", "<leader>fh", ":FzfCombiMode res=false mode=files<CR>", opts)

vim.keymap.set("n", "<leader>fl", ":FzfLua<CR>", opts)

vim.keymap.set("n", "<leader>fo", ":FzfLua oldfiles<CR>", opts)
vim.keymap.set("n", "<leader>fg", ":FzfLua git_files<CR>", opts)
vim.keymap.set("n", "<leader>fc", ":FzfLua colorschemes<CR>", opts)
vim.keymap.set("n", "<leader>fs", ":FzfLua grep_visual<CR>", opts)
vim.keymap.set("n", "<leader>fw", ":FzfLua grep_cword<CR>", opts)
vim.keymap.set("n", "<leader>fW", ":FzfLua grep_cWORD<CR>", opts)
vim.keymap.set("n", "<leader>fm", ":FzfLua marks<CR>", opts)
vim.keymap.set("n", "<leader>fr", ":FzfLua registers<CR>", opts)
vim.keymap.set("n", "<leader>fb", ":FzfLua buffers<CR>", opts)
vim.keymap.set("n", "<leader>fa", ":FzfLua tabs<CR>", opts)
vim.keymap.set("n", "<leader>fd", ":FzfLua man_pages<CR>", opts)
vim.keymap.set("n", "<leader>fe", ":FzfLua commands<CR>", opts)
vim.keymap.set("n", "<leader>st", function()
    vim.cmd([[TodoLocList]])
end, opts)
vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, opts)

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, opts)

-- Custom Keybindings
vim.keymap.set("n", "<leader>mdp", ":ToPdfFromMarkdown<CR>", opts)

vim.cmd([[
    augroup CustomKeybindings
    autocmd!

    autocmd FileType html nnoremap <buffer> <silent> <leader>sl :! browser-sync start --server --files "*.js, *.html, *.css" &; firefox-developer-edition localhost:3000/%:p & <CR>
    augroup end
]])

vim.keymap.set("n", "<leader>af", ":Lazy<CR>", opts)
vim.keymap.set("n", "<leader>ag", ":Mason<CR>", opts)

--------------------------------------------------------------
-- => Dap
---------------------------------------------------------------
vim.keymap.set("n", "<leader>dr", function() require("dap").restart() end, opts)
vim.keymap.set("n", "<leader>dq", function() require("dap").terminate() end, opts)
vim.keymap.set("n", "<leader>dd", function() require("dapui").toggle() end, opts)

vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, opts)
vim.keymap.set("n", "<leader>dj", function() require("dap").step_over() end, opts)
vim.keymap.set("n", "<leader>dk", function() require("dap").step_into() end, opts)
vim.keymap.set("n", "<leader>dl", function() require("dap").step_out() end, opts)
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, opts)
vim.keymap.set("n", "<leader>ds", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
    opts)
vim.keymap.set("n", "<leader>dv",
    function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, opts)
vim.keymap.set("n", "<leader>dt", function() require("dap").repl.toggle() end, opts)
vim.keymap.set("n", "<leader>de", function() require("dap").run_last() end, opts)
vim.keymap.set("n", "<leader>df", function() require("dapui").float_element() end, opts)
vim.keymap.set({ "n", "v" }, "<leader>dr", function() require("dapui").eval() end, opts)

vim.keymap.set({ "n", "v" }, "<leader>dh", function() require("dap.ui.widgets").hover() end)
vim.keymap.set({ "n", "v" }, "<leader>dp", function() require("dap.ui.widgets").preview() end)

vim.keymap.set("n", "<leader>dg", function() require "osv".launch({ port = 8086 }) end, opts)

-- vim.keymap.set("n", "<leader>df", function() require("dap.ui.widgets").centered_float(widgets.frames) end)
-- vim.keymap.set("n", "<leader>ds", function() require("dap.ui.widgets").centered_float(widgets.scopes) end)
