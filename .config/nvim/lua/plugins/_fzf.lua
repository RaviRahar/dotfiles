---------------------------------------------------------------
-- => FzfLua
---------------------------------------------------------------
local actions = require("fzf-lua.actions")
vim.cmd([[
    hi! FzfComment guifg=#787878
    hi! FzfBorder guifg=#ebdbb2 guibg=#282828
    hi! FzfNormal guifg=#ebdbb2 guibg=#282828
    hi! FzfNone cterm=none gui=none guifg=#282828 guibg=#282828

    hi! FzfSearch guifg=#ebdbb2 guibg=#282828
    hi! FzfPrompt cterm=bold gui=bold guifg=#83a598
    hi! FzfSelection cterm=bold gui=bold guifg=#fe8019
    hi! FzfTitle cterm=bold gui=bold guifg=#000000 guibg=#83a598
]])
require("fzf-lua").setup({
    winopts = {
        height = 0.80,
        width = 0.87,
        row = 0.35,
        col = 0.50,
        hl = {
            normal = "FzfNormal", -- window normal color (fg+bg)
            border = "FzfBorder", -- border color (try 'FloatBorder')
            -- Only valid with the builtin previewer:
            cursor = "FzfSelection", -- cursor highlight (grep/LSP matches)
            cursorline = "FzfNormal", -- cursor line
            search = "FzfSearch", -- search matches (ctags)
            title = "FzfTitle", -- preview border title (file/buffer)
            -- scrollbar_f = 'PmenuThumb',    -- scrollbar "full" section highlight
            -- scrollbar_e = 'PmenuSbar',     -- scrollbar "empty" section highlight
        },
        preview = {
            border = "border",
            wrap = "nowrap",
            hidden = "nohidden",
            vertical = "down:45%",
            horizontal = "right:60%",
            layout = "flex", -- horizontal|vertical|flex
            flip_columns = 120, -- #cols to switch to horizontal on flex
            -- Only valid with the builtin previewer:
            title = true, -- preview border title (file/buf)?
            scrollbar = "false", -- `false` or string:'float|border'
            -- float:  in-window floating border
            -- border: in-border chars (see below)
            scrolloff = "-2", -- float scrollbar offset from right
            -- applies only when scrollbar = 'float'
            scrollchars = { "", "" }, -- scrollbar chars ({ <full>, <empty> }
            -- applies only when scrollbar = 'border'
            delay = 100, -- delay(ms) displaying the preview
            -- prevents lag on fast scrolling
            winopts = { -- builtin previewer window options
                number = true,
                relativenumber = false,
                cursorline = false,
                cursorlineopt = "both",
                cursorcolumn = false,
                signcolumn = "no",
                list = false,
                foldenable = false,
                foldmethod = "manual",
            },
        },
        on_create = function()
            -- called once upon creation of the fzf main window
            -- can be used to add custom fzf-lua mappings, e.g:
            -- vim.kemap.set("t", "<C-j>", "<Down>", { silent = true, noremap = true, buffer = 0 })
        end,
    },
    keymap = {
        -- These override the default tables completely
        -- no need to set to `false` to disable a bind
        -- delete or modify is sufficient
        builtin = {
            -- neovim `:tmap` mappings for the fzf win
            ["<F1>"] = "toggle-help",
            ["<F2>"] = "toggle-fullscreen",
            -- Only valid with the 'builtin' previewer
            ["<F3>"] = "toggle-preview-wrap",
            ["<F4>"] = "toggle-preview",
            -- Rotate preview clockwise/counter-clockwise
            ["<F5>"] = "toggle-preview-ccw",
            ["<F6>"] = "toggle-preview-cw",
            ["<S-down>"] = "preview-page-down",
            ["<S-up>"] = "preview-page-up",
            ["<S-left>"] = "preview-page-reset",
        },
        fzf = {
            -- fzf '--bind=' options
            ["ctrl-z"] = "abort",
            ["ctrl-u"] = "unix-line-discard",
            ["ctrl-f"] = "half-page-down",
            ["ctrl-b"] = "half-page-up",
            ["ctrl-a"] = "beginning-of-line",
            ["ctrl-e"] = "end-of-line",
            ["alt-a"] = "toggle-all",
            -- Only valid with fzf previewers (bat/cat/git/etc)
            ["f3"] = "toggle-preview-wrap",
            ["f4"] = "toggle-preview",
            ["shift-down"] = "preview-page-down",
            ["shift-up"] = "preview-page-up",
        },
    },
    actions = {
        -- These override the default tables completely
        -- no need to set to `false` to disable an action
        -- delete or modify is sufficient
        files = {
            -- providers that inherit these actions:
            --   files, git_files, git_status, grep, lsp
            --   oldfiles, quickfix, loclist, tags, btags
            --   args
            -- default action opens a single selection
            -- or sends multiple selection to quickfix
            -- replace the default action with the below
            -- to open all files whether single or multiple
            ["default"] = actions.file_edit,
            ["ctrl-h"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
            ["ctrl-t"] = actions.file_tabedit,
        },
        buffers = {
            -- providers that inherit these actions:
            --   buffers, tabs, lines, blines
            ["default"] = actions.buf_edit,
            ["ctrl-h"] = actions.buf_split,
            ["ctrl-v"] = actions.buf_vsplit,
            ["ctrl-t"] = actions.buf_tabedit,
        },
    },
    fzf_opts = {
        -- options are sent as `<left>=<right>`
        -- set to `false` to remove a flag
        -- set to '' for a non-value flag
        -- for raw args use `fzf_args` instead
        ["--ansi"] = "",
        ["--prompt"] = "  ",
        ["--info"] = "default",
        ["--height"] = "100%",
        ["--layout"] = "reverse",
        ["--border"] = "none",
    },
    -- fzf '--color=' options (optional)
    fzf_colors = {
        ["fg"] = { "fg", "FzfNormal" },
        ["bg"] = { "bg", "FzfNormal" },
        ["hl"] = { "fg", "FzfComment" },
        ["fg+"] = { "fg", "FzfSelection" },
        ["bg+"] = { "bg", "FzfNormal" },
        ["hl+"] = { "fg", "FzfSelection" },
        ["info"] = { "fg", "FzfComment" },
        ["prompt"] = { "fg", "FzfPrompt" },
        ["pointer"] = { "fg", "FzfPrompt" },
        ["marker"] = { "fg", "FzfSelection" },
        ["spinner"] = { "fg", "FzfNormal" },
        ["header"] = { "fg", "FzfComment" },
        ["gutter"] = { "bg", "FzfNormal" },
    },
    files = {
        prompt = "Files  ",
    },
    git = {
        files = {
            prompt = "GitFiles  ",
            cmd = "git ls-files --exclude-standard",
        },
        status = {
            prompt = "GitStatus  ",
            cmd = "git status -s",
            previewer = "git_diff",
            actions = {
                -- actions inherit from 'actions.files' and merge
                ["right"] = { actions.git_unstage, actions.resume },
                ["left"] = { actions.git_stage, actions.resume },
            },
        },
        commits = {
            prompt = "Commits  ",
            cmd = "git log --pretty=oneline --abbrev-commit --color",
            preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
            actions = {
                ["default"] = actions.git_checkout,
            },
        },
        bcommits = {
            prompt = "BCommits  ",
        },
        branches = {
            prompt = "Branches  ",
        },
        stash = {
            prompt = "Stash  ",
        },
        icons = {
            ["M"] = { icon = "M", color = "yellow" },
            ["D"] = { icon = "D", color = "red" },
            ["A"] = { icon = "A", color = "green" },
            ["R"] = { icon = "R", color = "yellow" },
            ["C"] = { icon = "C", color = "yellow" },
            ["T"] = { icon = "T", color = "magenta" },
            ["?"] = { icon = "?", color = "magenta" },
            -- override git icons?
            -- ["M"]        = { icon = "★", color = "red" },
            -- ["D"]        = { icon = "✗", color = "red" },
            -- ["A"]        = { icon = "+", color = "green" },
        },
    },
    grep = {
        prompt = "Rg  ",
        input_prompt = "Grep For  ",
        grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=512",
        rg_glob = false, -- default to glob parsing?
        glob_flag = "--iglob", -- for case sensitive globs use '--glob'
        glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
    },
    args = {
        prompt = "Args  ",
        files_only = true,
    },
    oldfiles = {
        prompt = "History  ",
    },
    buffers = {
        prompt = "Buffers  ",
    },
    tabs = {
        prompt = "Tabs  ",
        tab_title = "Tab",
        tab_marker = " ◀ ",
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        actions = {
            -- actions inherit from 'actions.buffers' and merge
            ["default"] = actions.buf_switch,
            ["ctrl-x"] = { actions.buf_del, actions.resume },
        },
        fzf_opts = {
            -- hide tabnr
            ["--delimiter"] = "'[\\):]'",
            ["--with-nth"] = "2..",
        },
    },
    lines = {
        previewer = "builtin", -- set to 'false' to disable
        prompt = "Lines  ",
        show_unlisted = false, -- exclude 'help' buffers
        no_term_buffers = true, -- exclude 'term' buffers
        fzf_opts = {
            -- do not include bufnr in fuzzy matching
            -- tiebreak by line no.
            ["--delimiter"] = "'[\\]:]'",
            ["--nth"] = "2..",
            ["--tiebreak"] = "index",
        },
        -- actions inherit from 'actions.buffers' and merge
        actions = {
            ["default"] = { actions.buf_edit_or_qf },
            ["alt-q"] = { actions.buf_sel_to_qf },
        },
    },
    blines = {
        previewer = "builtin", -- set to 'false' to disable
        prompt = "BLines  ",
    },
    tags = {
        prompt = "Tags  ",
        ctags_file = "tags",
    },
    btags = {
        prompt = "BTags  ",
        ctags_file = "tags",
    },
    colorschemes = {
        prompt = "Colorschemes  ",
        winopts = { height = 0.55, width = 0.30 },
        post_reset_cb = function()
            -- reset statusline highlights after
            -- a live_preview of the colorscheme
            -- require('feline').reset_highlights()
        end,
    },
    quickfix = {
        file_icons = true,
        git_icons = true,
    },
    lsp = {
        prompt_postfix = "  ", -- will be appended to the LSP label
        -- to override use 'prompt' instead
        cwd_only = false, -- LSP/diagnostics for cwd only?
        async_or_timeout = 5000, -- timeout(ms) or 'true' for async calls
        file_icons = true,
        git_icons = false,
        lsp_icons = true,
        ui_select = true, -- use 'vim.ui.select' for code actions
        symbol_style = 1, -- style for document/workspace symbols
        -- false: disable,    1: icon+kind
        --     2: icon only,  3: kind only
        -- NOTE: icons are extracted from
        -- vim.lsp.protocol.CompletionItemKind
        -- colorize using nvim-cmp's CmpItemKindXXX highlights
        -- can also be set to 'TS' for treesitter highlights ('TSProperty', etc)
        -- or 'false' to disable highlighting
        symbol_hl_prefix = "CmpItemKind",
        -- additional symbol formatting, works with or without style
        symbol_fmt = function(s)
            return "[" .. s .. "]"
        end,
        severity = "hint",
        icons = {
            ["Error"] = { icon = "", color = "red" }, -- error
            ["Warning"] = { icon = "", color = "yellow" }, -- warning
            ["Information"] = { icon = "", color = "blue" }, -- info
            ["Hint"] = { icon = "", color = "magenta" }, -- hint
            ["Other"] = { icon = "﫠", color = "magenta" },
        },
    },
    -- uncomment to disable the previewer
    -- nvim = { marks = { previewer = { _ctor = false } } },
    -- helptags = { previewer = { _ctor = false } },
    -- manpages = { previewer = { _ctor = false } },
    -- uncomment to set dummy win location (help|man bar)
    -- "topleft"  : up
    -- "botright" : down
    -- helptags = { previewer = { split = "topleft" } },
    -- uncomment to use `man` command as native fzf previewer
    -- manpages = { previewer = { _ctor = require'fzf-lua.previewer'.fzf.man_pages } },
    -- optional override of file extension icon colors
    -- available colors (terminal):
    --    clear, bold, black, red, green, yellow
    --    blue, magenta, cyan, grey, dark_grey, white
    -- padding can help kitty term users with
    -- double-width icon rendering
    file_icon_padding = "",
    file_icon_colors = {
        ["lua"] = "blue",
    },
    -- uncomment if your terminal/font does not support unicode character
    -- 'EN SPACE' (U+2002), the below sets it to 'NBSP' (U+00A0) instead
    -- nbsp = '\xc2\xa0',
})
