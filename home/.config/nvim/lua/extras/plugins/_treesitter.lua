---------------------------------------------------------------
-- => Treesitter: Parser
---------------------------------------------------------------
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        lazy = true,
        event = "VimEnter",
        dependencies = { { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true } },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "lua",
                    "go",
                    "gomod",
                    "json",
                    "yaml",
                    "latex",
                    "make",
                    "python",
                    "rust",
                    "html",
                    "javascript",
                    "typescript",
                    "vue",
                    "css",
                },
                context_commentstring = {
                    enable = true,
                },
                highlight = { enable = true, disable = { "vim" } },
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]["] = "@function.outer",
                            ["]m"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]]"] = "@function.outer",
                            ["]M"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[["] = "@function.outer",
                            ["[m"] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[]"] = "@function.outer",
                            ["[M"] = "@class.outer",
                        },
                    },
                },
            })
            require("nvim-treesitter.install").prefer_git = true
            local parsers = require("nvim-treesitter.parsers").get_parser_configs()
            for _, p in pairs(parsers) do
                p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
            end
        end,
    },
}
