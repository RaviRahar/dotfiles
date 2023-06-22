local function lazy_bootstrap()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.uv.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)
end

local function lazy_theme()
    vim.cmd([[
                augroup LazyTheme
                    autocmd!
                    autocmd VimEnter * hi! LazyH1 cterm=bold gui=bold guifg=#000000 guibg=#83a598
                    autocmd VimEnter * hi! LazySpecial cterm=bold gui=bold guifg=#83a598
                    autocmd VimEnter * hi! LazyCommitType cterm=bold gui=bold guifg=#83a598
                    autocmd VimEnter * hi! LazyCommit guifg=#83a598
                    autocmd VimEnter * hi! LazyReasonCmd guifg=#83a598
                    autocmd VimEnter * hi! LazyDir guifg=#83a598
                    autocmd VimEnter * hi! LazyUrl guifg=#83a598
                    autocmd VimEnter * hi! LazyLocal guifg=#83a598
                    autocmd VimEnter * hi! LazyReasonFt guifg=#83a598
                    autocmd VimEnter * hi! LazyReasonEvent guifg=#83a598
                    autocmd VimEnter * hi! LazyCommitIssue guifg=#83a598
                    autocmd VimEnter * hi! LazyProgressDone guifg=#83a598
                    autocmd VimEnter * hi! LazyReasonSource guifg=#83a598
                    autocmd VimEnter * hi! LazyReasonPlugin guifg=#787878
                    autocmd VimEnter * hi! LazyReasonRuntime guifg=#787878
                augroup end
    ]])
end

local lazy_config = {
    root = vim.fn.stdpath("data") .. "/lazy",                      -- directory where plugins will be installed
    lockfile = vim.fn.stdpath("config") .. "/lazy/lazy-lock.json", -- lockfile generated after running update.
    state = vim.fn.stdpath("state") .. "/lazy/state.json",         -- state info for checker and other things
    defaults = { lazy = true },
    ui = {
        size = { width = 0.85, height = 0.7 },
        wrap = true,
        border = "rounded",
    },
    checker = { enabled = false },
    change_detection = { enabled = true, notify = false },
}

local lazy_setup = function()
    local lazy_view_config = require('lazy.view.config')
    lazy_view_config.keys.close = '<Esc>'
    -- {
    --   abort = "<C-c>",
    --   close = "q",
    --   details = "<cr>",
    --   diff = "d",
    --   hover = "K",
    --   profile_filter = "<C-f>",
    --   profile_sort = "<C-s>"
    -- }
end

local function load_plugins()
    lazy_bootstrap()
    lazy_theme()
    vim.loader.enable()
    lazy_setup()
    require("lazy").setup("extras.plugins", lazy_config)
    require("extras.keybindings")
    require("extras.lsp")
end

load_plugins()
