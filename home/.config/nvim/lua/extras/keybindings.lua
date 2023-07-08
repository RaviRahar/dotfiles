--------------------------------------------------------------
-- => Keybindings
---------------------------------------------------------------
local opts = { noremap = true, silent = true }
vim.cmd([[
    augroup CompatibilityKeybindings
    autocmd!

    autocmd FileType netrw nnoremap <buffer> <silent> <Esc> :Lexplore<CR>
    autocmd FileType undotree nnoremap <buffer> <silent> <Esc> :UndotreeToggle<CR>
    autocmd FileType diff nnoremap <buffer> <silent> <Esc> :UndotreeToggle<CR>
    autocmd FileType tagbar nnoremap <buffer> <silent> <Esc> :TagbarToggle<CR>
    autocmd FileType lazy nnoremap <buffer> <silent> <leader>l :quit!<CR>
    autocmd FileType mason nnoremap <buffer> <silent> <leader><C-l> :quit!<CR>
    autocmd FileType fzf nnoremap <buffer> <silent> <leader>fl :quit!<CR>
    autocmd FileType fzf nnoremap <buffer> <silent> <Esc> :quit!<CR>

    augroup end
]])

-- Toggle tagbar
vim.keymap.set("n", "<leader>j", ":TagbarToggle<CR>", opts)
vim.keymap.set("n", "<leader><C-j>", ":UndotreeToggle<CR>", opts)
-- Markdown
vim.keymap.set("n", "<leader>md", ":Glow<CR>", opts)
vim.keymap.set("n", "<leader>mt", ":MarkdownPreviewToggle<CR>", { silent = true, buffer = true })

-- Alpha (Dashboard)
vim.keymap.set("n", "<leader>nn", ":enew<CR>", opts)

-- Sniprun
vim.keymap.set("v", "<leader>rr", ":SnipRun<CR>", opts)
vim.keymap.set("n", "<leader>rr", ":SnipRun<CR>", opts)

-- Vim Fugitive Settings
vim.keymap.set("n", "<leader>gs", ":G<CR>", opts)
vim.keymap.set("n", "<leader>gab", ":G blame<CR>", opts)
vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", opts)
vim.keymap.set("n", "<leader>gf", ":G fetch --all<CR>", opts)

vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit!<CR>", opts)
vim.keymap.set("n", "<leader>gh", ":diffget //2<CR>", opts)
vim.keymap.set("n", "<leader>gl", ":diffget //3<CR>", opts)

-- Fzf Settings
vim.keymap.set("n", "<leader>ff", ":FzfCombiMode<CR>", opts)
vim.keymap.set("n", "<leader>fh", ":FzfCombiMode resume=false<CR>", opts)

vim.keymap.set("n", "<leader>fl", ":FzfLua<CR>", opts)
vim.keymap.set("v", "<leader>fl", ":FzfLua<CR>", opts)

vim.keymap.set("n", "<leader>fo", ":FzfLua oldfiles<CR>", opts)
vim.keymap.set("n", "<leader>fi", ":FzfLua git_files<CR>", opts)
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
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- Custom Keybindings
require("extras.custom.markdown_to_pdf")
vim.keymap.set("n", "<leader>mdp", ":MarkdownToPdf<CR>", opts)

vim.cmd([[
    augroup CustomKeybindings
    autocmd!

    autocmd FileType html nnoremap <buffer> <silent> <leader>sl :! browser-sync start --server --files "*.js, *.html, *.css" &; firefox-developer-edition localhost:3000/%:p & <CR>
    augroup end
]])

-- i as in Install
vim.keymap.set("n", "<leader><C-l>", ":Mason<CR>", opts)
-- p as in Packages
vim.keymap.set("n", "<leader>l", ":Lazy<CR>", opts)

--------------------------------------------------------------
-- => Dap
---------------------------------------------------------------
vim.keymap.set("n", "<leader>dn", function() require("dap").continue() end)
vim.keymap.set("n", "<leader>dj", function() require("dap").step_over() end)
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end)
vim.keymap.set("n", "<leader>do", function() require("dap").step_out() end)
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end)
vim.keymap.set("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
vim.keymap.set("n", "<leader>dl",
    function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end)
vim.keymap.set("n", "<leader>ds", function() require("dap").repl.open() end)
vim.keymap.set("n", "<leader>de", function() require("dap").run_last() end)
vim.keymap.set("n", "<leader>df", function() require("dapui").float_element() end)
vim.keymap.set("n", "<leader>dr", function() require("dapui").eval() end)
vim.keymap.set("v", "<leader>dr", function() require("dapui").eval() end)
