---------------------------------------------------------------
-- => Vim GitGutter Settings
---------------------------------------------------------------
require('gitsigns').setup{

  current_line_blame_opts = {
    virt_text = false,
  },

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then return ']h' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[h', function()
      if vim.wo.diff then return '[h' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>ghs', ':Gitsigns stage_hunk<CR>')
    map('n', '<leader>ghu', gs.undo_stage_hunk)

    -- Text object
    --map({'o', 'x'}, 'gih', ':<C-U>Gitsigns select_hunk<CR>')

  end
}
