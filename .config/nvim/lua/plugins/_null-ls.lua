vim.cmd([[packadd mason.nvim]])
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- null_ls.builtins.completion.spell,

        null_ls.builtins.diagnostics.codespell,
        null_ls.builtins.diagnostics.cpplint,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.diagnostics.jsonlint,

        null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.formatting.codespell,
        null_ls.builtins.formatting.black,
        -- null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.yamlfmt,
        null_ls.builtins.formatting.xmlformat,
        null_ls.builtins.formatting.fixjson,
    },
})
