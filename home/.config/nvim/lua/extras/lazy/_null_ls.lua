-------------------------------------------------------------------
-- => Null Ls to automatically setup install formatters and linters
-------------------------------------------------------------------
return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        lazy = true,
        dependencies = {
            { "nvim-lua/plenary.nvim", lazy = true },
            {
                "jay-babu/mason-null-ls.nvim",
                lazy = true,
                config = function()
                    require("mason-null-ls").setup({
                        ensure_installed = {
                            "jsonlint",
                            "shellcheck",
                            "eslint_d",
                            "shellcheck",
                            -- "rustfmt",
                            "black",
                            -- "stylua",
                            "clang_format",
                            "prettierd",
                            "xmlformatter",
                            "fixjson",
                            "shfmt",
                        },
                    })
                end,
            },
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                border = "rounded",
                -- cmd = { "nvim" },
                -- debounce = 250,
                -- debug = false,
                -- default_timeout = 5000,
                -- diagnostic_config = nil,
                -- diagnostics_format = "#{m}",
                -- fallback_severity = vim.diagnostic.severity.ERROR,
                -- log_level = "warn",
                -- notify_format = "[null-ls] %s",
                -- on_attach = custom_attach,
                -- on_init = nil,
                -- on_exit = nil,
                -- root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
                -- should_attach = nil,
                -- sources = nil,
                -- temp_dir = nil,
                -- update_in_insert = false,
                sources = {
                    -- null_ls.builtins.completion.spell,
                    -- null_ls.builtins.diagnostics.eslint_d,

                    -- null_ls.builtins.diagnostics.codespell,
                    -- null_ls.builtins.diagnostics.cpplint,
                    -- null_ls.builtins.diagnostics.flake8,
                    -- null_ls.builtins.diagnostics.markdownlint,
                    -- null_ls.builtins.diagnostics.yamllint,
                    null_ls.builtins.diagnostics.jsonlint,
                    null_ls.builtins.diagnostics.shellcheck,

                    null_ls.builtins.code_actions.eslint_d,
                    null_ls.builtins.code_actions.shellcheck,

                    -- null_ls.builtins.formatting.markdownlint,
                    -- null_ls.builtins.formatting.codespell,
                    null_ls.builtins.formatting.rustfmt,
                    null_ls.builtins.formatting.black,
                    -- null_ls.builtins.formatting.stylua,
                    -- null_ls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
                    null_ls.builtins.formatting.clang_format,
                    -- null_ls.builtins.formatting.clang_format.with({
                    --     extra_args = { "--style={ BasedOnStyle: InheritParentConfig } --fallback-style={ BasedOnStyle: Google }" },
                    -- }),
                    null_ls.builtins.formatting.prettierd,
                    -- null_ls.builtins.formatting.yamlfmt,
                    null_ls.builtins.formatting.xmlformat,
                    null_ls.builtins.formatting.fixjson,
                    -- null_ls.builtins.formatting.eslint_d,
                    null_ls.builtins.formatting.shfmt.with({
                        args = { "-i", "2", "-ln", "bash", "-fn", "-ci", "-sr" },
                    }),
                },
            })
        end,
    },
}
