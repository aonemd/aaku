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
        keymaps = {
          blame = '<Leader>gb', -- Open blame window
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
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  },
  {
    'iamcco/markdown-preview.nvim',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },

  -- COLORSCHEMES
  'aonemd/kuroi.vim',
  'aonemd/quietlight.vim',
  'B4mbus/oxocarbon-lua.nvim',
  'rebelot/kanagawa.nvim',
  { 'catppuccin/nvim', as = 'catppuccin' },
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
