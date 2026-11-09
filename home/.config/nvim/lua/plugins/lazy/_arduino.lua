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
            vim.keymap.set("n", "<leader>al", "<cmd>ArduinoUploadAndSerial<CR>", opts)
            vim.keymap.set("n", "<leader>am", "<cmd>ArduinoSerial<CR>", opts)
            vim.keymap.set("n", "<leader>ab", "<cmd>ArduinoChooseBoard<CR>", opts)
            vim.keymap.set("n", "<leader>ap", "<cmd>ArduinoChooseProgrammer<CR>", opts)

            -- Arduino statusline component
            local function arduino_status()
                if vim.bo.filetype ~= "arduino" then
                    return ""
                end

                local port = vim.fn["arduino#GetPort"]()
                local line = string.format("[%s]", vim.g.arduino_board or "Unknown")

                if (vim.g.arduino_programmer or "") ~= "" then
                    line = line .. string.format(" [%s]", vim.g.arduino_programmer)
                end

                if port ~= 0 then
                    line = line .. string.format(" (%s:%s)", port, vim.g.arduino_serial_baud)
                end

                return line
            end

            local colors = {
                blacktext = "#282828",
                skyblue = "#83a598",
                white = "#cbbba2",
                whitetext = "#ebdbb2",
                altwhitetext = "#cbbba2",
                green = "#689d6a",
                background = "#484848",
            }

            -- Register with Lualine
            local lualine = require("lualine")
            local config = lualine.get_config()

            -- table.insert(config.sections.lualine_x, 1, {
            --     arduino_status,
            --     icon = "󰚥",
            --     color = { bg = colors.green, fg = colors.blacktext },
            -- })

            table.insert(config.sections.lualine_x, 1, {
                arduino_status,
                icon = "󰚥",
                color = function()
                    if vim.fn.mode() == "n" then
                        return { bg = colors.green, fg = colors.blacktext }
                    end

                    return "lualine_x"
                end,
            })

            lualine.setup(config)
        end,
    },
}
