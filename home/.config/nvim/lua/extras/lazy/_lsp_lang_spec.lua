---------------------------------------------------------------
-- => Lsp Settings for different language specific plugins
---------------------------------------------------------------
return {
    {
        "mrcjkb/rustaceanvim",
        version = "^5", -- Recommended
        lazy = false,   -- plugin is already lazy
    },
    {
        "mfussenegger/nvim-jdtls",
        lazy = true,
        ft = "java",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

            local jdtls_loc = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
            local jdtls_binary_loc = jdtls_loc .. "/jdtls"
            local java_loc = "/usr/lib/jvm/java-23-openjdk/bin/java"
            local jdtls_jar_ver = "/plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.2.1100.v20240722-2106.jar"
            local jdtls_jar_loc = jdtls_loc .. jdtls_jar_ver
            local jdtls_config_loc = jdtls_loc .. "/config_linux"

            -- local root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" })
            local jdtls_setup = require "jdtls.setup"
            local root_dir = jdtls_setup.find_root { ".git", "mvnw", "gradlew" }
            local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
            local workspace_dir = vim.env.HOME .. "/.cache/jdtls/workspace/" .. project_name

            require("jdtls").start_or_attach({
                -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
                cmd = {
                    jdtls_binary_loc,
                    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                    '-Dosgi.bundles.defaultStartLevel=4',
                    '-Declipse.product=org.eclipse.jdt.ls.core.product',
                    '-Dlog.protocol=true',
                    '-Dlog.level=ALL',
                    '-Xmx1g',
                    '--add-modules=ALL-SYSTEM',
                    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

                    -- Need to configure these
                    '--java-executable', java_loc,
                    '-jar', jdtls_jar_loc,
                    '-configuration', jdtls_config_loc,
                    '-data', workspace_dir
                },

                -- or use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
                root_dir = root_dir,
                on_attach = function(client, bufnr)
                    jdtls_setup.add_commands()
                end,
                capabilities = capabilities,
                flags = { debounce_text_changes = 150 },

                -- Here you can configure eclipse.jdt.ls specific settings
                -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
                settings = {
                    java = {
                        configuration = {
                            runtimes = {
                                {
                                    name = "JavaSE-11",
                                    path = "/usr/lib/jvm/java-11-openjdk/",
                                },
                                {
                                    name = "JavaSE-23",
                                    path = "/usr/lib/jvm/java-23-openjdk/",
                                },
                            },
                        },
                    },
                },

                -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
                -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
                init_options = {
                    bundles = {},
                    extendedClientCapabilities = {
                        progressReportProvider = false,
                    }
                },
            })
        end
    },
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        config = function()
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
                        enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
                        background = false, -- highlight the background
                        foreground = false, -- highlight the foreground
                        virtual_text = true, -- show the highlight using virtual text
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
