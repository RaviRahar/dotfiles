---------------------------------------------------------------
-- => Snippet Plugins
---------------------------------------------------------------
return {
    {
        "mattn/emmet-vim",
        lazy = true,
        keys = { { "<C-b>", mode = { "i", "s" } } },
        ft = { "html", "css", "javascriptreact", "typescriptreact" },
        init = function()
            vim.g.user_emmet_mode = "iv"
            vim.g.user_emmet_leader_key = "<C-b>"
            vim.g.user_emmet_install_global = 0
            vim.cmd([[
                augroup Emmet
                autocmd!
                    autocmd FileType html,css,javascriptreact,typescriptreact EmmetInstall
                augroup end
            ]])
        end
    },
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        keys = { { "<C-f>", mode = { "i", "s" } } },
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            vim.opt.rtp:append(vim.env.HOME .. "/.config/nvim/my-snippets/")
            require("luasnip").config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
                region_check_events = "CursorHold,InsertLeave",
                delete_check_events = "TextChanged",
            })

            -- require("luasnip").filetype_extend("javascript", { "javascriptreact", "html" })
            -- require("luasnip").filetype_extend("typescript", { "typescriptreact", "html" })
            require("luasnip").filetype_extend("javascriptreact", { "html" })
            require("luasnip").filetype_extend("typescriptreact", { "html" })

            require("luasnip.loaders.from_lua").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load()

            local opts = { noremap = true, silent = true }
            local luasnip = require("luasnip")
            local snip_list = require("luasnip.extras.snippet_list")
            local function printer(snippets)
                local res = ""
                for ft, snips in pairs(snippets) do
                    res = res .. "[" .. ft .. "]\n\n"
                    for _, snip in pairs(snips) do
                        res = res .. [[Name: "]] .. snip.name .. [["]] .. "\n"
                        res = res .. [[Desc: "]] .. snip.description[1] .. [["]] .. "\n"
                        res = res .. [[Trigger: "]] .. snip.trigger .. [["]] .. "\n"
                        res = res .. "\n"
                    end
                end
                return res
            end
            local modified_default_display = snip_list.options.display({
                buf_opts = { filetype = "toml" },
            })

            -- vim.keymap.set({ "i" }, "<C-l>", function() luasnip.expand() end, opts)
            vim.keymap.set({ "i", "s" }, "<C-f>n", function() luasnip.jump(1) end, opts)
            vim.keymap.set({ "i", "s" }, "<C-f>N", function() luasnip.jump(-1) end, opts)

            vim.keymap.set({ "i", "s" }, "<C-f>,", function()
                if luasnip.choice_active() then
                    require("luasnip.extras.select_choice")()
                else
                    luasnip.expand()
                end
            end, opts)
            vim.keymap.set({ "i", "s" }, "<C-f>o",
                function()
                    vim.cmd("stopinsert")
                    snip_list.open()
                    vim.cmd.normal(vim.api.nvim_replace_termcodes(":0<CR>", true, true, true))
                end,
                opts)
            vim.keymap.set({ "i", "s" }, "<C-f>d",
                function()
                    vim.cmd("stopinsert")
                    snip_list.jump_to_active_snippet({ hl_duration_ms = 10 })
                    vim.cmd.normal(vim.api.nvim_replace_termcodes(":0<CR>", true, true, true))
                end,
                opts)
            vim.keymap.set({ "i", "s" }, "<C-f>l",
                function()
                    -- making our own printer
                    vim.cmd("stopinsert")
                    -- using it
                    snip_list.open({
                        printer = printer,
                        display = snip_list.options.display({
                            buf_opts = { filetype = "toml" },
                        })
                    })
                    vim.cmd.normal(vim.api.nvim_replace_termcodes(":0<CR>", true, true, true))
                end,
                opts)
        end
    }

}
