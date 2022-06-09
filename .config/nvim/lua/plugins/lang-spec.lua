---------------------------------------------------------------
-- => Dependencies
---------------------------------------------------------------
vim.cmd([[packadd cmp-nvim-lsp]])
---------------------------------------------------------------
-- => Language Specific Tools
---------------------------------------------------------------
local function custom_attach(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { noremap = true, silent = true }

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  buf_set_option('formatexpr', 'v:lua.vim.lsp.formatexpr()')


  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>dt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float({ focusable = false })<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>di', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>ft', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
  buf_set_keymap('v', '<leader>ft', '<cmd>lua vim.lsp.buf.range_formatting({ async = true })<CR>', opts)

  -- Stops cursor from going inside popup
  --vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { focusable = false, })
  --vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false, })
  -- Auto format using LSP on save
  --vim.api.nvim_exec([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]], false)

end
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

if vim.bo.filetype ==  "rust" then
require('rust-tools').setup({
  server = {
    standalone = true,
    on_attach = custom_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  },
})
end

if vim.bo.filetype ==  "c" or vim.bo.filetype ==  "cpp"then
require('clangd_extensions').setup {
  server = {
    on_attach = custom_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
}
end

if vim.bo.filetype ==  "html" or
    vim.bo.filetype == "css" or
   vim.bo.filetype == "xml" or
   vim.bo.filetype == "sass" or
   vim.bo.filetype == "javascript" or
   vim.bo.filetype == "typescript" or
   vim.bo.filetype == "typescriptreact" or
   vim.bo.filetype == "javascriptreact" then
-- emmet setup for now, don't know lua
capabilities.textDocument.completion.completionItem.snippetSupport = true
local configs = require('lspconfig.configs')

if not configs.ls_emmet then
  configs.ls_emmet = {
    setup = { capabilities = capabilities },
    default_config = {
      cmd = { 'ls_emmet', '--stdio' };
      filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'haml',
        'xml', 'xsl', 'pug', 'slim', 'sass', 'stylus', 'less', 'sss' };
      root_dir = function(fname)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end
end

if vim.bo.filetype ==  "dart" then
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
    on_attach = custom_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  },
}

--------------------------------------------------------------
-- => Flutter-tools Shortcuts
---------------------------------------------------------------
--Shortcuts
vim.api.nvim_set_keymap('n', '<leader>Fs', ':FlutterRun<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>Fd', ':FlutterDevices<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>Fe', ':FlutterEmulators<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>Fr', ':FlutterReload<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>Fa', ':FlutterRestart<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>Fq', ':FlutterQuit<CR>', { noremap = true, silent = true })
end
