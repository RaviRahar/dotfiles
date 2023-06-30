---------------------------------------------------------------
-- => Autocompletion provider
---------------------------------------------------------------
return {
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        event = "InsertEnter",
        dependencies = {
            { "onsails/lspkind-nvim",               lazy = true },
            { "lukas-reineke/cmp-under-comparator", lazy = true },
            --   Autocompletion sources
            {
                "L3MON4D3/LuaSnip",
                lazy = true,
                dependencies = { "rafamadriz/friendly-snippets" },
            },
            { "saadparwaiz1/cmp_luasnip",            lazy = true },
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

            --------Luasnips----------------
            local luasnip = require("luasnip")
            vim.o.runtimepath = vim.o.runtimepath .. "," .. os.getenv("HOME") .. "/.config/nvim/my-snippets/,"
            require("luasnip").config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
                region_check_events = "CursorHold,InsertLeave",
                delete_check_events = "TextChanged",
            })

            require("luasnip").filetype_extend("javascript", { "javascriptreact", "html" })
            require("luasnip").filetype_extend("typescript", { "typescriptreact", "html" })
            require("luasnip").filetype_extend("javascriptreact", { "html" })
            require("luasnip").filetype_extend("typescriptreact", { "html" })

            require("luasnip.loaders.from_lua").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load()

            local cmp = require("cmp")
            -------lua-stuff---------------
            local cmp_window = require("cmp.utils.window")
            function cmp_window:has_scrollbar()
                return false
            end

            -- local function has_words_before()
            --     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            --     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            -- end

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
                preselect = cmp.PreselectMode.None, -- Alt: cmp.PreselectMode.Item
                view = {
                    entries = "native",             -- can be "custom", "wildmenu" or "native"
                },
                experimental = {
                    ghost_text = true,
                },
                performance = {
                    debounce = 80,
                    throttle = 80,
                },
                completion = {
                    -- autocomplete = cmp.TriggerEvent | false,
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
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable,   -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<Tab>"] = cmp.config.disable,   -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<S-Tab>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        -- select = true,
                    }),
                    ["<C-f>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-b>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        require("cmp-under-comparator").under,
                        cmp.config.compare.recently_used,
                        require("clangd_extensions.cmp_scores"),
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                sources = {
                    { name = "luasnip" },
                    { name = "nvim_lua" },
                    { name = "nvim_lsp",               keyword_length = 2 },
                    { name = "nvim_lsp_signature_help" },
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
                            luasnip = "[LSnips]",
                            nvim_lua = "[Lua]",
                            nvim_lsp = "[LSP]",
                            path = "[Path]",
                            calc = "[Calc]",
                            look = "[Look]",
                            buffer = "[Buff]",
                            rg = "[Rg]",
                            crates = "[Crates]",
                            latex_symbols = "[LatexSyms]",
                        },
                    }),
                },
            })
        end,
    },
}
