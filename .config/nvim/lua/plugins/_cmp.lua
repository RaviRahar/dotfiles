---------------------------------------------------------------
-- => Dependencies
---------------------------------------------------------------
vim.cmd([[packadd cmp-nvim-lsp]])
vim.cmd([[packadd lspkind-nvim]])
vim.cmd([[packadd LuaSnip]])
vim.cmd([[packadd cmp-under-comparator]])
---------------------------------------------------------------
-- => CMP
---------------------------------------------------------------
-- Setup nvim-cmp --------------
local lspkind = require('lspkind')
lspkind.init()
local luasnip = require('luasnip')
local cmp = require('cmp')

-------lua-stuff---------------
local cmp_window = require('cmp.utils.window')
function cmp_window:has_scrollbar()
  return false
end

-- local function has_words_before()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

--local function border(hl)
--  return {
--    { "╭", hl },
--    { "─", hl },
--    { "╮", hl },
--    { "│", hl },
--    { "╯", hl },
--    { "─", hl },
--    { "╰", hl },
--    { "│", hl },
--  }
--end

cmp.setup({
   view = {
      entries = "native" -- can be "custom", "wildmenu" or "native"
   },
  experimental = {
    ghost_text = true,
  },
--  window = {
--    completion = {
--      border = border("CmpBorder"),
--    },
--    documentation = {
--      border = border("CmpDocBorder"),
--    },
--  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({
      --behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      --elseif has_words_before() then
        --cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  sorting = {
      comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          require('cmp-under-comparator').under,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
      },
  },

  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' , keyword_length = 2},
    { name = 'nvim_lsp_signature_help' },
    { name = 'npm' },
    { name = 'crates' },
    { name = 'orgmode' },
    { name = 'path' },
    { name = 'cmdline' },
    { name = 'calc' },
    { name = 'buffer', keyword_length = 5 },
    { name = 'rg', keyword_length = 5 },
    { name = 'latex_symbols' },
    { name = 'look', keyword_length = 5, option={convert_case=true, loud=true} },
  },

  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        luasnip = "[LSnips]",
        nvim_lua = "[Lua]",
        nvim_lsp = "[LSP]",
        path = "[Path]",
        cmdline = "[Cmd]",
        calc = "[Calc]",
        look = "[Look]",
        buffer = "[Buff]",
        rg = "[Rg]",
        orgmode = "[OrgMode]",
        npm = "[Npm]",
        crates = "[Crates]",
        latex_symbols = "[LatexSyms]",
      },
    },
  },

})

cmp.setup.cmdline('/', {
    completion = { autocomplete = false },
    sources = {
        -- { name = 'buffer' }
        { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
    },
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
    completion = { autocomplete = false },
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' }
    })
})


--------Luasnips----------------
vim.o.runtimepath = vim.o.runtimepath .. "," .. os.getenv("HOME") .. "/.config/nvim/my-snippets/,"
require('luasnip').config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
})
--require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_lua').lazy_load()
require('luasnip.loaders.from_snipmate').lazy_load()
