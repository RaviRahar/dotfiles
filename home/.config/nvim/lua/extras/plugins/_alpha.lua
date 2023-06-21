---------------------------------------------------------------
-- => Dashboard
---------------------------------------------------------------
return {
    {
        "goolord/alpha-nvim",
        lazy = true,
        event = "VimEnter",
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            --          local logo = {
            --                 [[                               ]],
            --                 [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
            --                 [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡖⠁⠀⠀⠀⠀⠀⠀⠈⢲⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
            --                 [[⠀⠀⠀⠀⠀⠀⠀⠀⣼⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣧⠀⠀⠀⠀⠀⠀⠀⠀ ]],
            --                 [[⠀⠀⠀⠀⠀⠀⠀⣸⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣇⠀⠀⠀⠀⠀⠀⠀ ]],
            --                 [[⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⢀⣀⣤⣤⣤⣤⣀⡀⠀⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀ ]],
            --                 [[⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣔⢿⡿⠟⠛⠛⠻⢿⡿⣢⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀ ]],
            --                 [[⠀⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣷⣤⣀⡀⢀⣀⣤⣾⣿⣿⣿⣷⣶⣤⡀⠀⠀⠀⠀ ]],
            --                 [[⠀⠀⢠⣾⣿⡿⠿⠿⠿⣿⣿⣿⣿⡿⠏⠻⢿⣿⣿⣿⣿⠿⠿⠿⢿⣿⣷⡀⠀⠀ ]],
            --                 [[⠀⢠⡿⠋⠁⠀⠀⢸⣿⡇⠉⠻⣿⠇⠀⠀⠸⣿⡿⠋⢰⣿⡇⠀⠀⠈⠙⢿⡄⠀ ]],
            --                 [[⠀⡿⠁⠀⠀⠀⠀⠘⣿⣷⡀⠀⠰⣿⣶⣶⣿⡎⠀⢀⣾⣿⠇⠀⠀⠀⠀⠈⢿⠀ ]],
            --                 [[⠀⡇⠀⠀⠀⠀⠀⠀⠹⣿⣷⣄⠀⣿⣿⣿⣿⠀⣠⣾⣿⠏⠀⠀⠀⠀⠀⠀⢸⠀ ]],
            --                 [[⠀⠁⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⢇⣿⣿⣿⣿⡸⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠈⠀ ]],
            --                 [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
            --                 [[⠀⠀⠀⠐⢤⣀⣀⢀⣀⣠⣴⣿⣿⠿⠋⠙⠿⣿⣿⣦⣄⣀⠀⠀⣀⡠⠂⠀⠀⠀ ]],
            --                 [[⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠉⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠋⠁⠀⠀⠀⠀⠀ ]],
            --                 [[                               ]],
            --             }

            local logo = [[

           ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
           ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
           ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
           ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
           ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
           ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝

            ]]

            dashboard.section.header.val = vim.split(logo, "\n")
            dashboard.section.buttons.val = {
                dashboard.button("<leader> f c", "  Scheme change", "<cmd>Telescope colorscheme<cr>"),
                dashboard.button("<leader> f p", "  Project find", "<cmd>Telescope project<cr>"),
                dashboard.button("<leader> f r", "  Recent Files", "<cmd>Telescope frecency<cr>"),
                dashboard.button("<leader> f b", "  File Browser", ":Telescope file_browser <CR>"),
                dashboard.button("<leader> n n", "  File new", "<cmd>enew<cr>"),
                dashboard.button("q", " " .. " Quit", ":qa<CR>"),
                -- dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
                -- dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
                -- dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
                -- dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
                -- dashboard.button("q", " " .. " Quit", ":qa<CR>"),
            }
            for _, button in ipairs(dashboard.section.buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end
            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.section.footer.opts.hl = "AlphaFooter"
            dashboard.opts.layout[1].val = 8
            return dashboard
        end,
        config = function(_, dashboard)
            -- close Lazy and re-open when the dashboard is ready
            vim.g.hidden_all = 0
            vim.api.nvim_create_user_command("ToggleHiddenAll", function()
                if vim.g.hidden_all == 0 then
                    vim.g.hidden_all = 1
                    vim.opt.laststatus = 0
                    vim.opt.showtabline = 0
                    vim.opt.showmode = false
                    vim.opt.ruler = false
                    vim.opt.showcmd = false
                else
                    vim.g.hidden_all = 0
                    vim.opt.laststatus = 2
                    vim.opt.showtabline = 2
                    vim.opt.showmode = true
                    vim.opt.ruler = true
                    vim.opt.showcmd = true
                end
            end, {})

            vim.cmd([[
                augroup HideAll
                    autocmd!
                    autocmd User AlphaReady :ToggleHiddenAll
                    autocmd User AlphaReady :autocmd! BufLeave,BufEnter <buffer> :ToggleHiddenAll
                augroup end
            ]])
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            require("alpha").setup(dashboard.opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },
}
