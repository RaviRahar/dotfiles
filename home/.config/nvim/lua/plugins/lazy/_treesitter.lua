---------------------------------------------------------------
-- => Treesitter: Parser
---------------------------------------------------------------
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        lazy = true,
        event = "BufWinEnter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "lua",
                    "go",
                    "gomod",
                    "json",
                    "yaml",
                    "latex",
                    "markdown",
                    "make",
                    "python",
                    "rust",
                    "html",
                    "javascript",
                    "typescript",
                    "vue",
                    "css",
                    "vim",
                    "vimdoc",
                },
                highlight = {
                    enable = true,
                    use_languagetree = false,
                    disable = function(_, bufnr)
                        if vim.bo.ft == "tex" or vim.bo.ft == "plaintex" then
                            return true
                        end
                        local buf_name = vim.api.nvim_buf_get_name(bufnr)
                        local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
                        return file_size > 256 * 1024
                    end,
                },
            })
            require("nvim-treesitter.install").prefer_git = true
            local parsers = require("nvim-treesitter.parsers").get_parser_configs()
            for _, p in pairs(parsers) do
                p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
            end
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        event = { "CursorMoved", "InsertEnter" },
        init = function() vim.g.skip_ts_context_commentstring_module = true end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true,
        event = { "CursorMoved", "InsertEnter" },
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]["] = "@function.outer",
                            ["]m"] = "@class.outer",
                            ["]a"] = "@parameter.outer",
                        },
                        goto_next_end = {
                            ["]]"] = "@function.outer",
                            ["]M"] = "@class.outer",
                            ["]A"] = "@parameter.outer",
                        },
                        goto_previous_start = {
                            ["[["] = "@function.outer",
                            ["[m"] = "@class.outer",
                            ["[a"] = "@parameter.outer",
                        },
                        goto_previous_end = {
                            ["[]"] = "@function.outer",
                            ["[M"] = "@class.outer",
                            ["[A"] = "@parameter.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_previous = {
                            ["[a"] = "@parameter.inner",
                        },
                        swap_next = {
                            ["]a"] = "@parameter.inner",
                        },
                    },
                },
            })
            local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

            -- Repeat movement with ; and ,
            -- ensure ; goes forward and , goes backward regardless of the last direction
            -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
            -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

            -- vim way: ; goes to the direction you were moving.
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
        end

    }
}
