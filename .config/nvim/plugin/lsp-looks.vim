"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lsp-Highlight Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   -- Enable underline, use default values
   underline = true,
   -- Enable virtual text only on Warning or above, override spacing to 2
   virtual_text = false,}
)

local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
    Other = "﫠",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

EOF
