---------------------------------------------------------------
-- => For Latex files
---------------------------------------------------------------
return {
    {
        "stevearc/vim-arduino",
        lazy = true,
        ft = { "arduino" },
        config = function()
            local opts = { buffer = true, noremap = true, silent = true }

            vim.keymap.set("n", "<leader>aa", "<cmd>ArduinoAttach<CR>", opts)
            vim.keymap.set("n", "<leader>av", "<cmd>ArduinoVerify<CR>", opts)
            vim.keymap.set("n", "<leader>au", "<cmd>ArduinoUpload<CR>", opts)
            vim.keymap.set("n", "<leader>aus", "<cmd>ArduinoUploadAndSerial<CR>", opts)
            vim.keymap.set("n", "<leader>as", "<cmd>ArduinoSerial<CR>", opts)
            vim.keymap.set("n", "<leader>ab", "<cmd>ArduinoChooseBoard<CR>", opts)
            vim.keymap.set("n", "<leader>ap", "<cmd>ArduinoChooseProgrammer<CR>", opts)
        end,
    },
}
