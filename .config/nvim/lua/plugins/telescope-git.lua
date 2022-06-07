---------------------------------------------------------------
-- => Vim Fugitive Settings
---------------------------------------------------------------

vim.api.nvim_set_keymap('n', '<leader>gs', ':G<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ga', ':Git fetch --all<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>gh', ':diffget //3<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gu', ':diffget //2<CR>', { noremap = true, silent = true })

---------------------------------------------------------------
-- => Telescope Settings
---------------------------------------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["<C-f>"] = require('telescope.actions').preview_scrolling_up,
        ["<C-b>"] = require('telescope.actions').preview_scrolling_down,
      },
      n = {
        ["<C-f>"] = require('telescope.actions').preview_scrolling_up,
        ["<C-b>"] = require('telescope.actions').preview_scrolling_down,
      },
    }
  }
}

vim.api.nvim_set_keymap('n', '<leader>ts', ':Telescope<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope oldfiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fc', ':Telescope colorscheme<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fw', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fm', ':Telescope marks<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>mp', ':Telescope man_pages<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cmd', ':Telescope commands<CR>', { noremap = true, silent = true })

--vim.api.nvim_set_keymap('n', '<leader>gs', ':Telescope git_status<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gc', ':Telescope git_branches<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gl', ':Telescope git_commits<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gll', ':Telescope git_bcommits<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>ga', ':Telescope git_stash<CR>', { noremap = true, silent = true })

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

