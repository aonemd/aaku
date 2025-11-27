local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'plugins.treesitter' },
  { import = 'plugins.lsp' },
  { import = 'plugins.mason' },
  -- { import = 'plugins.cmp' },
  { import = 'plugins.blink' },
  { import = 'plugins.telescope' },
  { import = 'plugins.conform' },
  { import = 'plugins.oil' },
  { import = 'plugins.gitsigns' },
  { import = 'plugins.fold' },
  { import = 'plugins.codecompanion' },
  'rktjmp/hotpot.nvim',
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  },
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    config = function()
      require('plugins.git')
    end,
  },
  {
    'dinhhuy258/git.nvim',
    config = function()
      require('git').setup({
        default_mappings = true,
        keymaps = {
          browse = '<Leader>go', -- Open file/folder in git repository
        },
      })
    end,
  },
  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    config = function()
      require('mini.surround').setup()
    end,
  },
  {
    'junegunn/vim-easy-align',
    config = function()
      vim.cmd([[
        nmap <leader>a <Plug>(EasyAlign)
        xmap <leader>a <Plug>(EasyAlign)
      ]])
    end,
  },
  {
    'jinh0/eyeliner.nvim',
    config = function()
      require('eyeliner').setup({
        -- show highlights only after keypress
        highlight_on_key = true,
        -- dim all other characters if set to true (recommended!)
        dim = false,
        -- set the maximum number of characters eyeliner.nvim will check from
        -- your current cursor position; this is useful if you are dealing with
        -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
        max_length = 9999,
        -- filetypes for which eyeliner should be disabled;
        -- e.g., to disable on help files:
        -- disabled_filetypes = {"help"}
        disabled_filetypes = {},
        -- buftypes for which eyeliner should be disabled
        -- e.g., disabled_buftypes = {"nofile"}
        disabled_buftypes = {},
        -- add eyeliner to f/F/t/T keymaps;
        -- see section on advanced configuration for more information
        default_keymaps = true,
      })
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'chrisgrieser/nvim-genghis',
    dependencies = {
      'stevearc/dressing.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-omni',
    },
  },
  {
    'Pocco81/true-zen.nvim',
    config = function()
      require('true-zen').setup()
    end,
  },
  -- LANGUAGE SUPPORT
  'mfussenegger/nvim-jdtls',
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup({
        diagnostic = false,
      })
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
      'davidosomething/format-ts-errors.nvim',
    },
  },
  {
    'OlegGulevskyy/better-ts-errors.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = {
      keymaps = {
        toggle = '<leader>dd', -- default '<leader>dd'
        go_to_definition = '<leader>dx' --[[ default '<leader>dx' ]],
      },
    },
  },
  {
    'mrcjkb/haskell-tools.nvim',
    version = '^3', -- Recommended
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
    ft = {
      'md',
      'markdown',
      'norg',
      'rmd',
      'org',
      'vimwiki',
      'typst',
      'latex',
      'quarto',
      'Avante',
      'codecompanion',
    },
    opts = {
      experimental = { check_rtp_message = false },
      preview = {
        filetypes = {
          'md',
          'markdown',
          'norg',
          'rmd',
          'org',
          'vimwiki',
          'typst',
          'latex',
          'quarto',
          'Avante',
          'codecompanion',
        },
        icon_provider = 'devicons',
        ignore_buftypes = {},
        max_buf_lines = 9999,
      },
    },
  },

  -- COLORSCHEMES
  {
    'rebelot/kanagawa.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  { 'catppuccin/nvim', as = 'catppuccin', lazy = false, priority = 1000 },
  { 'aonemd/kuroi.vim', lazy = false },
  { 'aonemd/quietlight.vim', lazy = false },
  { 'B4mbus/oxocarbon-lua.nvim', lazy = false },
  { 'oxfist/night-owl.nvim', lazy = false },
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
