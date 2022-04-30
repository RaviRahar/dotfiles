""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Flutter-tools
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Shortcuts
nnoremap <silent> <leader>Fs :FlutterRun<CR>
nnoremap <silent> <leader>Fd :FlutterDevices<CR>
nnoremap <silent> <leader>Fe :FlutterEmulators<CR>
nnoremap <silent> <leader>Fr :FlutterReload<CR>
nnoremap <silent> <leader>Fa :FlutterRestart<CR>
nnoremap <silent> <leader>Fq :FlutterQuit<CR>

lua << EOF

-- alternatively you can override the default configs
require("flutter-tools").setup {
  ui = {
    -- the border type to use for all floating windows, the same options/formats
    -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
    border = "rounded",
    notification_style = 'plugin'
  },
  decorations = {
    statusline = {
      app_version = true,
      device = true,
    }
  },
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    highlight = "ErrorMsg", -- highlight for the closing tag
    prefix = ">", -- character to use for close tag e.g. > Widget
    enabled = true -- set to false to disable
  },
  lsp = {
    color = { -- show the derived colours for dart variables
      enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
      background = false, -- highlight the background
      foreground = false, -- highlight the foreground
      virtual_text = true, -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
  },
}

EOF
