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
        dependencies = {
        },
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
                    "make",
                    "python",
                    "rust",
                    "html",
                    "javascript",
                    "typescript",
                    "vue",
                    "css",
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                    use_languagetree = false,
                    disable = function(_, bufnr)
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
        event = { "CursorMoved", "ModeChanged" },
        config = function()
            require("nvim-treesitter.configs").setup({
                context_commentstring = {
                    enable = true,
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true,
        event = { "CursorMoved", "ModeChanged" },
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
                        },
                        goto_next_end = {
                            ["]]"] = "@function.outer",
                            ["]M"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[["] = "@function.outer",
                            ["[m"] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[]"] = "@function.outer",
                            ["[M"] = "@class.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["]s"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["[s"] = "@parameter.inner",
                        },
                    },
                },
            })
            -- Make ; , repeat movements
            vim.keymap.set({ "n", "x", "o" }, ";", ":TSTextobjectRepeatLastMove<CR>")
            vim.keymap.set({ "n", "x", "o" }, ",", ":TSTextobjectRepeatLastMoveOpposite<CR>")

            -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
            vim.keymap.set({ "n", "x", "o" }, "f", ":TSTextobjectBuiltinf<CR>")
            vim.keymap.set({ "n", "x", "o" }, "F", ":TSTextobjectBuiltinF<CR>")
            vim.keymap.set({ "n", "x", "o" }, "t", ":TSTextobjectBuiltint<CR>")
            vim.keymap.set({ "n", "x", "o" }, "T", ":TSTextobjectBuiltinT<CR>")
        end

    }
}