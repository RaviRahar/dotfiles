---------------------------------------------------------------
-- => Treesitter: Parser
---------------------------------------------------------------
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        -- Do NOT lazy-load as suggested in docs
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")

            local parsers = {
                "asm",
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
                "arduino",
            }

            ts.setup({
                -- default location
                install_dir = vim.fn.stdpath("data") .. "/site",
            })

            ts.install(parsers)

            local group = vim.api.nvim_create_augroup("user_treesitter", {
                clear = true,
            })

            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                callback = function(args)
                    local bufnr = args.buf
                    local ft = vim.bo[bufnr].filetype

                    if ft == "tex" or ft == "plaintex" then
                        return
                    end

                    local buf_name = vim.api.nvim_buf_get_name(bufnr)
                    local file_size = buf_name ~= "" and vim.fn.getfsize(buf_name) or 0

                    if file_size > 256 * 1024 then
                        return
                    end

                    pcall(vim.treesitter.start, bufnr)
                end,
            })
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        event = { "CursorMoved", "InsertEnter" },
        config = function()
            require("ts_context_commentstring").setup({
                -- update commentstring automatically
                -- remove if integration with Comment.nvim / mini.comment
                -- set this false and call the integration hook instead
                enable_autocmd = true,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "af", mode = { "x", "o" } },
            { "if", mode = { "x", "o" } },
            { "ac", mode = { "x", "o" } },
            { "ic", mode = { "x", "o" } },

            { "][", mode = { "n", "x", "o" } },
            { "]m", mode = { "n", "x", "o" } },
            { "]a", mode = { "n", "x", "o" } },
            { "]]", mode = { "n", "x", "o" } },
            { "]M", mode = { "n", "x", "o" } },
            { "]A", mode = { "n", "x", "o" } },

            { "[[", mode = { "n", "x", "o" } },
            { "[m", mode = { "n", "x", "o" } },
            { "[a", mode = { "n", "x", "o" } },
            { "[]", mode = { "n", "x", "o" } },
            { "[M", mode = { "n", "x", "o" } },
            { "[A", mode = { "n", "x", "o" } },

            { "[s", mode = "n" },
            { "]s", mode = "n" },

            { ";", mode = { "n", "x", "o" } },
            { ",", mode = { "n", "x", "o" } },

            { "f", mode = { "n", "x", "o" } },
            { "F", mode = { "n", "x", "o" } },
            { "t", mode = { "n", "x", "o" } },
            { "T", mode = { "n", "x", "o" } },
        },

        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                },
                move = {
                    set_jumps = true,
                },
            })

            local ts_select = require("nvim-treesitter-textobjects.select")
            local ts_move = require("nvim-treesitter-textobjects.move")
            local ts_swap = require("nvim-treesitter-textobjects.swap")
            local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

            ---------------------------------------------------------------
            -- Textobject select
            ---------------------------------------------------------------
            vim.keymap.set({ "x", "o" }, "af", function()
                ts_select.select_textobject("@function.outer", "textobjects")
            end, { desc = "Select outer function" })

            vim.keymap.set({ "x", "o" }, "if", function()
                ts_select.select_textobject("@function.inner", "textobjects")
            end, { desc = "Select inner function" })

            vim.keymap.set({ "x", "o" }, "ac", function()
                ts_select.select_textobject("@class.outer", "textobjects")
            end, { desc = "Select outer class" })

            vim.keymap.set({ "x", "o" }, "ic", function()
                ts_select.select_textobject("@class.inner", "textobjects")
            end, { desc = "Select inner class" })

            ---------------------------------------------------------------
            -- Textobject move
            ---------------------------------------------------------------
            vim.keymap.set({ "n", "x", "o" }, "][", function()
                ts_move.goto_next_start("@function.outer", "textobjects")
            end, { desc = "Next function start" })

            vim.keymap.set({ "n", "x", "o" }, "]m", function()
                ts_move.goto_next_start("@class.outer", "textobjects")
            end, { desc = "Next class start" })

            vim.keymap.set({ "n", "x", "o" }, "]a", function()
                ts_move.goto_next_start("@parameter.outer", "textobjects")
            end, { desc = "Next parameter start" })

            vim.keymap.set({ "n", "x", "o" }, "]]", function()
                ts_move.goto_next_end("@function.outer", "textobjects")
            end, { desc = "Next function end" })

            vim.keymap.set({ "n", "x", "o" }, "]M", function()
                ts_move.goto_next_end("@class.outer", "textobjects")
            end, { desc = "Next class end" })

            vim.keymap.set({ "n", "x", "o" }, "]A", function()
                ts_move.goto_next_end("@parameter.outer", "textobjects")
            end, { desc = "Next parameter end" })

            vim.keymap.set({ "n", "x", "o" }, "[[", function()
                ts_move.goto_previous_start("@function.outer", "textobjects")
            end, { desc = "Previous function start" })

            vim.keymap.set({ "n", "x", "o" }, "[m", function()
                ts_move.goto_previous_start("@class.outer", "textobjects")
            end, { desc = "Previous class start" })

            vim.keymap.set({ "n", "x", "o" }, "[a", function()
                ts_move.goto_previous_start("@parameter.outer", "textobjects")
            end, { desc = "Previous parameter start" })

            vim.keymap.set({ "n", "x", "o" }, "[]", function()
                ts_move.goto_previous_end("@function.outer", "textobjects")
            end, { desc = "Previous function end" })

            vim.keymap.set({ "n", "x", "o" }, "[M", function()
                ts_move.goto_previous_end("@class.outer", "textobjects")
            end, { desc = "Previous class end" })

            vim.keymap.set({ "n", "x", "o" }, "[A", function()
                ts_move.goto_previous_end("@parameter.outer", "textobjects")
            end, { desc = "Previous parameter end" })

            ---------------------------------------------------------------
            -- Textobject swap
            ---------------------------------------------------------------
            vim.keymap.set("n", "[s", function()
                ts_swap.swap_previous("@parameter.inner")
            end, { desc = "Swap previous parameter" })

            vim.keymap.set("n", "]s", function()
                ts_swap.swap_next("@parameter.inner")
            end, { desc = "Swap next parameter" })

            ---------------------------------------------------------------
            -- Repeatable move
            ---------------------------------------------------------------
            -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, {
            --     desc = "Repeat last treesitter move forward",
            -- })

            -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous, {
            --     desc = "Repeat last treesitter move backward",
            -- })

            -- vim way

            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move, {
                desc = "Repeat last treesitter move backward",
            })

            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite, {
                desc = "Repeat last treesitter move backward",
            })

            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, {
                expr = true,
                desc = "Builtin f repeatable",
            })

            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, {
                expr = true,
                desc = "Builtin F repeatable",
            })

            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, {
                expr = true,
                desc = "Builtin t repeatable",
            })

            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, {
                expr = true,
                desc = "Builtin T repeatable",
            })
        end,
    },
}
