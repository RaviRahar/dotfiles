---------------------------------------------------------------
-- => Autocompletion provider
---------------------------------------------------------------
return {
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        event = "InsertEnter",
        dependencies = {
            { "onsails/lspkind-nvim",                lazy = true },
            -- Snippets
            {
                "L3MON4D3/LuaSnip",
                lazy = true,
                dependencies = { "rafamadriz/friendly-snippets" },
            },
            {
                "mattn/emmet-vim",
                lazy = true,
                keys = { { "<C-b>", mode = { "i", "s" } } },
                ft = { "html", "css", "javascriptreact", "typescriptreact" },
                init = function()
                    vim.g.user_emmet_mode = "iv"
                    vim.g.user_emmet_leader_key = "<C-b>"
                    vim.g.user_emmet_install_global = 0
                end,
                config = function() vim.cmd([[EmmetInstall]]) end
            },
            { "saadparwaiz1/cmp_luasnip",            lazy = true },
            { "dcampos/cmp-emmet-vim",               lazy = true },
            --   Autocompletion sources
            { "hrsh7th/cmp-path",                    lazy = true },
            { "hrsh7th/cmp-buffer",                  lazy = true },
            { "lukas-reineke/cmp-rg",                lazy = true },
            { "hrsh7th/cmp-calc",                    lazy = true },
            { "octaltree/cmp-look",                  lazy = true },
            { "hrsh7th/cmp-nvim-lsp",                lazy = true },
            { "hrsh7th/cmp-nvim-lsp-signature-help", lazy = true },
            { "hrsh7th/cmp-nvim-lua",                lazy = true },
            {
                "kdheepak/cmp-latex-symbols",
                lazy = true,
                event = "InsertEnter",
                enabled = function() if (vim.bo.ft == "tex" or vim.bo.ft == "plaintex") then return false else return true end end,
            },
            {
                "saecki/crates.nvim",
                lazy = true,
                ft = { "toml" },
                -- event = { "BufRead Cargo.toml" },
                config = function()
                    require("crates").setup()
                end,
            },
        },
        config = function()
            -- Lsp-kind  --------------
            local lspkind = require("lspkind")
            lspkind.init()
            -------- Luasnip ----------------
            local luasnip = require("luasnip")
            vim.opt.rtp:append(vim.env.HOME .. "/.config/nvim/my-snippets/")

            require("luasnip").filetype_extend("javascript", { "javascriptreact", "html" })
            require("luasnip").filetype_extend("typescript", { "typescriptreact", "html" })
            require("luasnip").filetype_extend("javascriptreact", { "html" })
            require("luasnip").filetype_extend("typescriptreact", { "html" })

            require("luasnip.loaders.from_lua").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load()

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

            local snip_list = require("luasnip.extras.snippet_list")
            local opts = { noremap = true, silent = true }

            vim.keymap.set({ "i", "s" }, "<C-f>o",
                function()
                    vim.cmd("stopinsert")
                    snip_list.open()
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

            vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = '*',
                callback = function()
                    if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
                        and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
                        and not require('luasnip').session.jump_active
                    then
                        require('luasnip').unlink_current()
                    end
                end,
                group = vim.api.nvim_create_augroup("MyLuaSnipHistory", { clear = true })
            })
            -------Cmp-Config---------------
            local cmp = require("cmp")

            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            cmp.setup({
                preselect = cmp.PreselectMode.None,
                view = {
                    entries = {
                        name = "native", -- can be "custom", "wildmenu" or "native"
                        selection_order = "top_down",
                    },
                },
                experimental = {
                    ghost_text = true,
                },
                performance = {
                    debounce = 60,
                    throttle = 60,                -- 30, 60
                    fetching_timeout = 500,       -- 500, 300
                    confirm_resolve_timeout = 60, -- 80, 60
                    async_budget = 4,             -- 1, 4
                    max_view_entries = 50,        -- 200, 200
                },
                completion = {
                    -- autocomplete = true,
                    completeopt = "menu,menuone,noinsert,noselect",
                    keyword_length = 2,
                },
                matching = {
                    disallow_fuzzy_matching = false,
                    disallow_partial_matching = false,
                    disallow_prefix_unmatching = false,
                },
                window = {
                    completion = {
                        scrollbar = false,
                    }
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = {
                    ["<C-n>"] = function()
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                        else
                            cmp.complete({ config = { reason = cmp.ContextReason.Auto } })
                        end
                    end,
                    ["<C-p>"] = function()
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                        else
                            cmp.complete({
                                config = {
                                    reason = cmp.ContextReason.Auto,
                                    view = { entries = { selection_order = "bottom_up" }
                                    }
                                }
                            })
                        end
                    end,
                    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-Space>"] = cmp.config.disable,
                    ["<Tab>"] = cmp.config.disable,
                    ["<S-Tab>"] = cmp.config.disable,
                    ["<C-e>"] = function()
                        cmp.abort()
                        cmp.core:reset()
                    end,
                    ["<C-l>"] = function()
                        cmp.complete({ config = { reason = cmp.ContextReason.Auto } })
                    end,
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }),
                    ["<C-f>n"] = cmp.mapping(function()
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { "i", "s" }),
                    ["<C-f>N"] = cmp.mapping(function()
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" }),
                },
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        function(entry1, entry2)
                            local _, entry1_under = entry1.completion_item.label:find "^_+"
                            local _, entry2_under = entry2.completion_item.label:find "^_+"
                            entry1_under = entry1_under or 0
                            entry2_under = entry2_under or 0
                            if entry1_under > entry2_under then
                                return false
                            elseif entry1_under < entry2_under then
                                return true
                            end
                        end,
                        cmp.config.compare.recently_used,
                        require("clangd_extensions.cmp_scores"),
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                        cmp.complete
                    },
                },
                sources = {
                    { name = "nvim_lsp_signature_help" },
                    { name = 'emmet_vim',              max_item_count = 1 },
                    { name = "luasnip",                max_item_count = 2 },
                    { name = "nvim_lua",               priority = 9 },
                    { name = "nvim_lsp" },
                    { name = "crates" },
                    { name = "path" },
                    { name = "calc" },
                    { name = "buffer",                 keyword_length = 4 },
                    { name = "rg",                     keyword_length = 4 },
                    { name = "latex_symbols" },
                    {
                        name = "look",
                        keyword_length = 5,
                        option = { convert_case = true, loud = true },
                    },
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol',
                        maxwidth = 36,
                        with_text = true,
                        menu = {
                            luasnip = "[Snip]",
                            emmet_vim = "[Emmet]",
                            nvim_lua = "[Lua]",
                            nvim_lsp = "[LSP]",
                            path = "[Path]",
                            calc = "[Calc]",
                            look = "[Dict]",
                            buffer = "[Buf]",
                            rg = "[Rg]",
                            crates = "[Crates]",
                            latex_symbols = "[Latex]",
                        },
                    }),
                },
            })
        end,
    },
}
