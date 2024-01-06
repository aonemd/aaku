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
  { import = 'plugins.cmp' },
  { import = 'plugins.lsp' },
  { import = 'plugins.telescope' },
  { import = 'plugins.guard' },
  { import = 'plugins.nvim-tree' },
  { import = 'plugins.gitsigns' },
  'rktjmp/hotpot.nvim',
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  },
  {
    'tpope/vim-fugitive',
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
  {
    'jackMort/ChatGPT.nvim',
    branch = 'main',
    commit = 'd4aa4d9',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('chatgpt').setup({
        openai_params = {
          model = 'gpt-4',
          max_tokens = 1000,
        },
      })
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

  -- COLORSCHEMES
  { 'aonemd/kuroi.vim', lazy = false, priority = 1000 },
  { 'aonemd/quietlight.vim', lazy = false, priority = 1000 },
  { 'B4mbus/oxocarbon-lua.nvim', lazy = false, priority = 1000 },
  { 'rebelot/kanagawa.nvim', lazy = false, priority = 1000 },
  { 'catppuccin/nvim', as = 'catppuccin', lazy = false, priority = 1000 },
  {
    'oxfist/night-owl.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
