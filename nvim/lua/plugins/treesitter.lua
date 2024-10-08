return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
      "windwp/nvim-ts-autotag",
    },
    event = { "BufReadPre", "BufNewFile" },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'lua',
          'fennel',
          'scheme',
          'go',
          'rust',
          'c',
          'java',
          'kotlin',
          'ruby',
          'typescript',
          'javascript',
          'tsx',
          'html',
          'json',
          'yaml',
          'toml',
          'markdown'
        },
        auto_install = true,

        highlight = {
          enable = true, -- false will disable the whole extension.

          additional_vim_regex_highlighting = false,

          disable = { 'ruby' },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gtt',
            node_incremental = 'gtn',
            scope_incremental = 'gtc',
            node_decremental = 'gtm',
          },
        },
        indent = {
          enable = false,
        },
        autotag = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim.
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm.
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
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
      })
    end
  },
}
