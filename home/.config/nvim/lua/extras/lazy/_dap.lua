----------------------------------------
-- => Debugger for neovim
----------------------------------------
return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        dependencies = {
            { "rcarriga/nvim-dap-ui",  lazy = true },
            { "nvim-neotest/nvim-nio", lazy = true },
            {
                "jay-babu/mason-nvim-dap.nvim",
                cmd = { "DapInstall", "DapUninstall" },
                config = function()
                    require('mason-nvim-dap').setup({
                        ensure_installed = {},
                        automatic_installation = true,
                        handlers = {
                            function(config)
                                require('mason-nvim-dap').default_setup(config)
                            end,
                        },
                    })
                end
            },

        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")

            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
            }

            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = true,
                    stopOnEntry = false,
                } }

            dap.configurations.c = dap.configurations.cpp

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸" },
                mappings = {
                    -- Use a table to apply multiple mappings
                    edit = "e",
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    repl = "r",
                    toggle = "t"
                },
                layouts = {
                    {
                        elements = {
                            -- Provide as ID strings or tables with "id" and "size" keys
                            {
                                id = "scopes",
                                size = 0.25, -- Can be float or integer > 1
                            },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks",      size = 0.25 },
                            { id = "watches",     size = 00.25 },
                        },
                        size = 40,
                        position = "left",
                    },
                    {
                        elements = { "repl" },
                        size = 10,
                        position = "bottom",
                    },
                },
                floating = {
                    max_height = 0.6,
                    max_width = 0.85,
                    mappings = { close = { "q", "<Esc>" } },
                },
                windows = { indent = 1 },
            })
        end,
    }
}
