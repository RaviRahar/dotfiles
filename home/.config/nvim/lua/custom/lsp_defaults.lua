--------------------------------------------------------------
-- => Server-Configs
---------------------------------------------------------------
vim.lsp.config('*', {
    root_markers = { '.git' },
    flags = { debounce_text_changes = 150 },
})

vim.lsp.enable({
    "rust_analyzer",
    "gopls",
    -- "hls",
    "bashls",
    "lua_ls",
    "clangd",
    "pyright",
    "html",
    "quick_lint_js",
    "jsonls",
    "tsserver",
    "cmake",
    "cssls",
    -- "jdtls",


    -- "kotlin_language_server",
    -- "jedi_language_server",
    -- "eslint_d",
    -- "flake8",
    -- "jsonlint",
    -- "black",
    "stylua",
    "clang-format",
    "prettierd",
    -- "xmlformat",
    -- "fixjson",
})

vim.lsp.config["rust_analyzer"] = {
    standalone = true,
    cmd = { "rust-analyzer" },
    flags = {
        debounce_text_changes = 150,
    },
}

vim.lsp.config["gopls"] = {
    flags = { debounce_text_changes = 500 },
    cmd = { "gopls", "-remote=auto" },
    settings = {
        gopls = {
            usePlaceholders = true,
            analyses = {
                nilness = true,
                shadow = true,
                unusedparams = true,
                unusewrites = true,
            },
        },
    },
}

vim.lsp.config["kotlin_language_server"] = {
    flags = { debounce_text_changes = 150 },
    settings = {
        kotlin = {
            debounceTime = 150,
            linting = { debounceTime = 150 },
            indexing = { enabled = false },
            debugAdapter = { enabled = false },
            completion = { snippets = { enabled = true } },
        },
    },
}

vim.lsp.config["hls"] = {
    single_file_support = true,
    flags = { debounce_text_changes = 150 },
    filetypes = { "haskell", "lhaskell", "cabal" },
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    workspace_required = true,
    root_markers = { "hie.yaml", "stack.yaml", "cabal.project", ".cabal", "package.yaml" },
    settings = {
        haskell = {
            cabalFormattingProvider = "cabalfmt",
            formattingProvider = "ormolu",
        },
    },
}

vim.lsp.config["kotlin_language_server"] = {
    settings = {
        ltex = {
            enabled = {
                "bibtex",
                "gitcommit",
                "markdown",
                "org",
                "tex",
                "restructuredtext",
                "rsweave",
                "latex",
                "quarto",
                "rmd",
                "context",
                "html",
                "xhtml",
                "mail",
            },
        },
    },
}

vim.lsp.config["lua_ls"] = {
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
                library = {
                    ["/usr/share/awesome/lib/"] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
                ignoreDir = {
                    ".vscode",
                    ".git",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
                -- maxPreload = 5000,
                -- preloadFileSize = 500,
            },
            completion = {
                enable = true,
            },
            diagnostics = {
                enable = true,
                globals = { "vim", "awesome", "client", "mouse", "root", "screen" },
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("ClangdConfig", {}),
    pattern = {
        "*.c",
        "*.cpp",
        "*.cc",
        "*.cxx",
        "*.c++",
        "*.cp",
        "*.C",
        "*.h",
        "*.hpp",
        "*.hh",
        "*.hxx",
        "*.h++",
    },
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }
        vim.keymap.set("n", "gh", ":ClangdSwitchSourceHeader<CR>", bufopts)
    end,
})

vim.lsp.config["clangd"] = {
    cmd = {
        -- see clangd --help-hidden
        "clangd",
        -- default: -checks=clang-diagnostic-*,clang-analyzer-*
        -- add-extra: .clang-tidy file in the root directory
        -- "--cross-file-rename", -- obsolete hence ignored
        -- "-std=c++20",
        "--background-index",
        "--pch-storage=memory",
        -- "--clang-tidy",
        "--suggest-missing-includes",
        "--completion-style=bundled",
        "--header-insertion=iwyu",
    },
    init_options = {
        clangdFileStatus = true,
        usePlaceholders = true,
        completeUnimported = true,
        semanticHighlighting = true,
    },
    single_file_support = true,
    -- workspace_required = true,
    root_markers = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_flags.txt",
        ".git",
        "configure.ac",
        "compile_commands.json",
    },
}

vim.lsp.config["jsonls"] = {
    flags = { debounce_text_changes = 500 },
    settings = {
        json = {
            -- Schemas https://www.schemastore.org
            schemas = {
                {
                    fileMatch = { "package.json" },
                    url = "https://json.schemastore.org/package.json",
                },
                {
                    fileMatch = { "tsconfig*.json" },
                    url = "https://json.schemastore.org/tsconfig.json",
                },
                {
                    fileMatch = {
                        ".prettierrc",
                        ".prettierrc.json",
                        "prettier.config.json",
                    },
                    url = "https://json.schemastore.org/prettierrc.json",
                },
                {
                    fileMatch = { ".eslintrc", ".eslintrc.json" },
                    url = "https://json.schemastore.org/eslintrc.json",
                },
                {
                    fileMatch = {
                        ".babelrc",
                        ".babelrc.json",
                        "babel.config.json",
                    },
                    url = "https://json.schemastore.org/babelrc.json",
                },
                {
                    fileMatch = { "lerna.json" },
                    url = "https://json.schemastore.org/lerna.json",
                },
                {
                    fileMatch = {
                        ".stylelintrc",
                        ".stylelintrc.json",
                        "stylelint.config.json",
                    },
                    url = "http://json.schemastore.org/stylelintrc.json",
                },
                {
                    fileMatch = { "/.github/workflows/*" },
                    url = "https://json.schemastore.org/github-workflow.json",
                },
            },
        },
    },
}
