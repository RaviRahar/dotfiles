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
vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", opts)
vim.keymap.set("n", "<leader>gf", ":G fetch --all<CR>", opts)

vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit!<CR>", opts)
vim.keymap.set("n", "<leader>gh", ":diffget //2<CR>", opts)
vim.keymap.set("n", "<leader>gl", ":diffget //3<CR>", opts)

-- Fzf Settings
vim.keymap.set("n", "<leader>ff", ":FzfCombiMode<CR>", opts)
vim.keymap.set("n", "<leader>fh", ":FzfCombiMode res=false<CR>", opts)

vim.keymap.set("n", "<leader>fl", ":FzfLua<CR>", opts)

vim.keymap.set("n", "<leader>fo", ":FzfLua oldfiles<CR>", opts)
vim.keymap.set("n", "<leader>fg", ":FzfLua git_files<CR>", opts)
vim.keymap.set("n", "<leader>fc", ":FzfLua colorschemes<CR>", opts)
vim.keymap.set("n", "<leader>fs", ":FzfLua grep_visual<CR>", opts)
vim.keymap.set("n", "<leader>fw", ":FzfLua grep_cword<CR>", opts)
vim.keymap.set("n", "<leader>fW", ":FzfLua grep_cWORD<CR>", opts)
vim.keymap.set("n", "<leader>fm", ":FzfLua marks<CR>", opts)
vim.keymap.set("n", "<leader>fr", ":FzfLua registers<CR>", opts)
vim.keymap.set("n", "<leader>bb", ":FzfLua buffers<CR>", opts)
vim.keymap.set("n", "<leader>aa", ":FzfLua tabs<CR>", opts)
vim.keymap.set("n", "<leader>man", ":FzfLua man_pages<CR>", opts)
vim.keymap.set("n", "<leader>cmd", ":FzfLua commands<CR>", opts)
vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, opts)

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, opts)

-- Custom Keybindings
require("extras.custom.markdown_to_pdf")
vim.keymap.set("n", "<leader>mdp", ":MarkdownToPdf<CR>", opts)

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
vim.keymap.set("n", "<leader>dn", function() require("dap").continue() end, opts)
vim.keymap.set("n", "<leader>dj", function() require("dap").step_over() end, opts)
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, opts)
vim.keymap.set("n", "<leader>do", function() require("dap").step_out() end, opts)
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, opts)
vim.keymap.set("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
    opts)
vim.keymap.set("n", "<leader>dl",
    function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, opts)
vim.keymap.set("n", "<leader>ds", function() require("dap").repl.open() end, opts)
vim.keymap.set("n", "<leader>de", function() require("dap").run_last() end, opts)
vim.keymap.set("n", "<leader>df", function() require("dapui").float_element() end, opts)
vim.keymap.set("n", "<leader>dr", function() require("dapui").eval() end, opts)
vim.keymap.set("v", "<leader>dr", function() require("dapui").eval() end, opts)
