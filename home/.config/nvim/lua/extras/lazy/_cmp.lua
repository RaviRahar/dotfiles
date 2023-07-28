---------------------------------------------------------------
-- => Autocompletion provider
---------------------------------------------------------------
return {
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        event = "InsertEnter",
        dependencies = {
            -- Icons
            { "onsails/lspkind-nvim",                lazy = true },
            -- Snippet Engine
            { "L3MON4D3/LuaSnip",                    lazy = true },
            --   Autocompletion sources
            { "hrsh7th/cmp-path",                    lazy = true },
            { "hrsh7th/cmp-buffer",                  lazy = true },
            { "lukas-reineke/cmp-rg",                lazy = true },
            { "hrsh7th/cmp-calc",                    lazy = true },
            { "octaltree/cmp-look",                  lazy = true },
            { "hrsh7th/cmp-nvim-lsp",                lazy = true },
            { "hrsh7th/cmp-nvim-lsp-signature-help", lazy = true },
            { "hrsh7th/cmp-nvim-lua",                lazy = true },
            { "kdheepak/cmp-latex-symbols",          lazy = true, ft = { "tex" } },
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
            -- Setup nvim-cmp --------------
            local lspkind = require("lspkind")
            lspkind.init()

            local cmp = require("cmp")
            -------lua-stuff---------------
            local cmp_window = require("cmp.utils.window")
            function cmp_window:has_scrollbar()
                return false
            end

            -- local function border(hl)
            --     return {
            --         { "╭", hl },
            --         { "─", hl },
            --         { "╮", hl },
            --         { "│", hl },
            --         { "╯", hl },
            --         { "─", hl },
            --         { "╰", hl },
            --         { "│", hl },
            --     }
            -- end
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
                    debounce = 80,
                    throttle = 80,
                },
                completion = {
                    autocomplete = false,
                    completeopt = "menu,menuone,noinsert",
                    keyword_length = 2,
                },
                matching = {
                    disallow_fuzzy_matching = false,
                    disallow_partial_matching = false,
                    disallow_prefix_unmatching = false,
                },
                -- window = {
                --     completion = {
                --         border = border("CmpBorder"),
                --     },
                --     documentation = {
                --         border = border("CmpDocBorder"),
                --     },
                -- },
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
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        -- select = true,
                    }),
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
                    { name = "nvim_lua" },
                    { name = "nvim_lsp" },
                    { name = "crates" },
                    { name = "path" },
                    { name = "calc" },
                    { name = "buffer",                 keyword_length = 5 },
                    { name = "rg",                     keyword_length = 5 },
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
