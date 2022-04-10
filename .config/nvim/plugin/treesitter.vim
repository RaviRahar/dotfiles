lua <<EOF
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = ';kn',
      node_incremental = ';kt',
      scope_incremental = ';kc',
      node_decremental = ';km',
    },
  },
--  indent = {
--    enable = true,
--  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
     keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        [';fo'] = '@function.outer',
        [';fi'] = '@function.inner',
        [';co'] = '@class.outer',
        [';ci'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}
EOF
