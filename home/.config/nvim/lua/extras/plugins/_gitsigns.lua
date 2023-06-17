---------------------------------------------------------------
-- => Vim GitSigns
---------------------------------------------------------------
return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = { "BufRead", "BufNewFile" },
        config = function()
            require("gitsigns").setup({

                current_line_blame_opts = {
                    virt_text = false,
                },

                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    vim.keymap.set("n", "]h", function()
                        if vim.wo.diff then
                            return "]h"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, buffer = bufnr })

                    vim.keymap.set("n", "[h", function()
                        if vim.wo.diff then
                            return "[h"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, buffer = bufnr })

                    -- Actions
                    vim.keymap.set({ "n", "v" }, "<leader>ghs", gs.stage_hunk, { buffer = bufnr })
                    vim.keymap.set({ "n", "v" }, "<leader>ghu", gs.undo_stage_hunk, { buffer = bufnr })

                    -- Text object
                    -- vim.keymap.set({ "o", "x" }, "gih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr })
                end,
            })
        end,
    },
}
