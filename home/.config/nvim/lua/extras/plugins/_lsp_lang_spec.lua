---------------------------------------------------------------
-- => Lsp Settings for different language specific plugins
---------------------------------------------------------------
return {
    {
        "simrat39/rust-tools.nvim",
        lazy = true,
        ft = "rust",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("rust-tools").setup({
                server = {
                    standalone = true,
                    cmd = { "rust-analyzer" },
                    capabilities = capabilities,
                    flags = {
                        debounce_text_changes = 150,
                    },
                },
            })
        end,
    },
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local nvim_lsp = require("lspconfig")
            local function switch_source_header_splitcmd(bufnr, splitcmd)
                bufnr = nvim_lsp.util.validate_bufnr(bufnr)
                local clangd_client = nvim_lsp.util.get_active_client_by_name(bufnr, "clangd")
                local params = { uri = vim.uri_from_bufnr(bufnr) }
                if clangd_client then
                    clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
                        if err then
                            error(tostring(err))
                        end
                        if not result then
                            print("Corresponding file can’t be determined")
                            return
                        end
                        vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
                    end)
                else
                    print(
                        "method textDocument/switchSourceHeader is not supported by any servers active on the current buffer"
                    )
                end
            end

            -- START: adding sorter to nvim-cmp
            local cmp = require("cmp")
            local cmp_config = cmp.get_config()

            local no_comparators = 0

            for _ in ipairs(cmp_config.sorting.comparators) do
                no_comparators = no_comparators + 1
            end

            table.insert(cmp_config.sorting.comparators, no_comparators / 2, require("clangd_extensions.cmp_scores"))
            cmp.setup(cmp_config)
            -- END: adding sorter to nvim-cmp

            local copy_capabilities_clangd = capabilities
            copy_capabilities_clangd.offsetEncoding = { "utf-16" }


            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('ClangdConfig', {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
                    vim.keymap.set("n", "gh", ":ClangdSwitchSourceHeader<CR>", bufopts)
                end,
            })
            require("clangd_extensions").setup({
                extensions = {
                    inlay_hints = {
                        inline = false,
                        -- inline = vim.fn.has("nvim-0.10") == 1,
                        -- only_current_line = true,
                        -- only_current_line_autocmd = "CursorMoved,CursorMovedI",
                        -- show_parameter_hints = false,
                    },
                },
                server = {
                    cmd = {
                        -- see clangd --help-hidden
                        "clangd",
                        "--background-index",
                        -- default: -checks=clang-diagnostic-*,clang-analyzer-*
                        -- add-extra: .clang-tidy file in the root directory
                        "--clang-tidy",
                        "--completion-style=bundled",
                        "--cross-file-rename",
                        "--header-insertion=iwyu",
                    },
                    init_options = {
                        clangdFileStatus = true,
                        usePlaceholders = true,
                        completeUnimported = true,
                        semanticHighlighting = true,
                    },
                    capabilities = copy_capabilities_clangd,
                    single_file_support = true,
                    args = {
                        "--background-index",
                        "-std=c++20",
                        "--pch-storage=memory",
                        "--clang-tidy",
                        "--suggest-missing-includes",
                    },
                    root_dir = nvim_lsp.util.root_pattern(
                        ".clangd",
                        ".clang-tidy",
                        ".clang-format",
                        "compile_flags.txt",
                        ".git",
                        "configure.ac",
                        "compile_commands.json"
                    ),
                    commands = {
                        ClangdSwitchSourceHeader = {
                            function()
                                switch_source_header_splitcmd(0, "edit")
                            end,
                            description = "Open source/header in current buffer",
                        },
                        ClangdSwitchSourceHeaderVSplit = {
                            function()
                                switch_source_header_splitcmd(0, "vsplit")
                            end,
                            description = "Open source/header in a new vsplit",
                        },
                        ClangdSwitchSourceHeaderSplit = {
                            function()
                                switch_source_header_splitcmd(0, "split")
                            end,
                            description = "Open source/header in a new split",
                        },
                    },
                },
            })
        end,
    },
    {
        "akinsho/flutter-tools.nvim",
        lazy = true,
        ft = "dart",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("flutter-tools").setup({
                ui = {
                    -- the border type to use for all floating windows, the same options/formats
                    -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
                    border = "rounded",
                    notification_style = "plugin",
                },
                decorations = {
                    statusline = {
                        app_version = true,
                        device = true,
                    },
                },
                widget_guides = {
                    enabled = true,
                },
                closing_tags = {
                    highlight = "ErrorMsg", -- highlight for the closing tag
                    prefix = ">",           -- character to use for close tag e.g. > Widget
                    enabled = true,         -- set to false to disable
                },
                lsp = {
                    color = {
                        -- show the derived colours for dart variables
                        enabled = true,         -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
                        background = false,     -- highlight the background
                        foreground = false,     -- highlight the foreground
                        virtual_text = true,    -- show the highlight using virtual text
                        virtual_text_str = "■", -- the virtual text character to highlight
                    },
                    capabilities = capabilities,
                    flags = {
                        debounce_text_changes = 150,
                    },
                },
            })

            --------------------------------------------------------------
            -- => Flutter-tools Shortcuts
            ---------------------------------------------------------------
            --Shortcuts
            vim.keymap.set("n", "<leader>Fs", ":FlutterRun<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>Fd", ":FlutterDevices<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>Fe", ":FlutterEmulators<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>Fr", ":FlutterReload<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>Fa", ":FlutterRestart<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>Fq", ":FlutterQuit<CR>", { noremap = true, silent = true })
        end,
    },
}
