--------------------------------------------------------------
-- => Keybindings
---------------------------------------------------------------
local opts = { noremap = true, silent = true }

-- Toggle tagbar
vim.keymap.set("n", "<leader><C-l>", ":TagbarToggle<CR>", opts)
vim.keymap.set("n", "<leader>L", ":UndotreeToggle<CR>", opts)
-- Markdown
vim.keymap.set("n", "<leader>md", ":Glow<CR>", opts)
vim.keymap.set("n", "<leader>mt", ":MarkdownPreviewToggle<CR>", { silent = true, buffer = true })

-- Alpha (Dashboard)
vim.keymap.set("n", "<leader>nn", ":enew<CR>", opts)

-- Sniprun
vim.keymap.set("v", "<leader>r", ":SnipRun<CR>", opts)
vim.keymap.set("n", "<leader>r", ":SnipRun<CR>", opts)

-- Trouble
vim.keymap.set("n", "<leader>st", ":TroubleToggle<CR>", opts)
vim.keymap.set("n", "<leader>qf", ":Trouble quickfix<CR>", opts)

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
vim.keymap.set("n", "<leader>fw", ":Telescope live_grep initial_mode=normal<CR>", opts)
vim.keymap.set("n", "<leader>*", ":Telescope grep_string initial_mode=normal<CR>", opts)
vim.keymap.set("n", "<leader>fm", ":Telescope marks<CR>", opts)
vim.keymap.set("n", "<leader>fr", ":Telescope frecency<CR>", opts)
vim.keymap.set("n", "<leader>fp", ":Telescope project<CR>", opts)
vim.keymap.set("n", "<leader>bb", ":Telescope buffers initial_mode=normal<CR>", opts)
vim.keymap.set("n", "<leader>aa", ":Telescope telescope-tabs list_tabs initial_mode=normal<CR>", opts)
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser <CR>", opts)

vim.keymap.set("n", "<leader>man", ":Telescope man_pages<CR>", opts)
vim.keymap.set("n", "<leader>cmd", ":Telescope commands<CR>", opts)
vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

--vim.keymap.set("n", "<leader>gs", ":Telescope git_status<CR>", opts)
-- vim.keymap.set("n", "<leader>gc", ":Telescope git_branches<CR>", opts)
-- vim.keymap.set("n", "<leader>gl", ":Telescope git_commits<CR>", opts)
-- vim.keymap.set("n", "<leader>gll", ":Telescope git_bcommits<CR>", opts)
--vim.keymap.set("n", "<leader>ga", ":Telescope git_stash<CR>", opts)

-- Custom Keybindings
require("extras.customs._markdown_to_pdf")
vim.keymap.set("n", "<leader>mdp", ":MarkdownToPdf<CR>", opts)

vim.cmd([[
    augroup CustomKeybindings
    autocmd!

    autocmd FileType html nnoremap <buffer> <silent> <leader>sl :! browser-sync start --server --files "*.js, *.html, *.css" &; firefox-developer-edition localhost:3000/%:p & <CR>
    augroup end
]])

-- i as in Install
vim.keymap.set("n", "<leader>i", ":Mason<CR>", opts)
-- p as in Packages
vim.keymap.set("n", "<leader>p", ":Lazy<CR>", opts)

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


--------------------------------------------------------------
-- => Treesitter
---------------------------------------------------------------
-- local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, ',', ts_repeat_move.repeat_last_move_previous)

-- -- vim way: ; goes to the direction you were moving.
-- -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
-- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
-- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
-- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
-- vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
