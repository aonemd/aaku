local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
  },

  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'nvim-treesitter/nvim-treesitter-textobjects',
  'nvim-treesitter/nvim-treesitter-context',

  'hrsh7th/nvim-cmp', -- Autocompletion plugin.
  'hrsh7th/cmp-buffer', -- Autocompletion plugin.
  'hrsh7th/cmp-path', -- Autocompletion plugin.
  'hrsh7th/cmp-cmdline', -- Autocompletion plugin.
  'hrsh7th/cmp-nvim-lsp', -- Provide completions from LSP
  'saadparwaiz1/cmp_luasnip', -- Snippet completion
  -- snippets
  'L3MON4D3/LuaSnip', -- Snippets plugin, snippet "engine"
  'rafamadriz/friendly-snippets', -- a bunch of snippets to use

  -- LSP
  'neovim/nvim-lspconfig', -- enable LSP
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  -- use "jose-elias-alvarez/null-ls.nvim"   -- for formatters and linters
	{
		"nvimdev/guard.nvim",
		dependencies = {
      { "nvimdev/guard-collection" }
		},
	},

  'rktjmp/hotpot.nvim',

  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require'nvim-web-devicons'.setup()
    end
  },

  'nvim-tree/nvim-tree.lua',

  {
    "jackMort/ChatGPT.nvim",
    branch= "main",
    commit= "d4aa4d9",
    config = function()
      require("chatgpt").setup({
        openai_params = {
          model = "gpt-4",
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },

  'tpope/vim-fugitive',
  {
    'dinhhuy258/git.nvim',
    config = function()
      require('git').setup({
        keymaps = {
          -- Open blame window
          blame = '<Leader>gb',
          -- Open file/folder in git repository
          browse = '<Leader>go',
        },
      })
    end,
  },
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  'JoosepAlviste/nvim-ts-context-commentstring',
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },
  'machakann/vim-sandwich',
  'junegunn/vim-easy-align',
  {
    'Pocco81/true-zen.nvim',
    config = function()
      require('true-zen').setup({
        -- your config goes here
        -- or just leave it empty :)
      })
    end,
  },
  'norcalli/nvim-colorizer.lua',
  {
    'chrisgrieser/nvim-genghis',
    dependencies = {
      'stevearc/dressing.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-omni',
    },
  },
  'aonemd/kuroi.vim',
  'aonemd/quietlight.vim',
  'B4mbus/oxocarbon-lua.nvim',
  'rebelot/kanagawa.nvim',
  { 'catppuccin/nvim', as = 'catppuccin' },
  'mfussenegger/nvim-jdtls',
  'ray-x/go.nvim',
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
})

require('plugins.cmp')
require('plugins.lsp')
-- require("plugins.null-ls")
require('plugins.guard')
require('plugins.treesitter')
require('plugins.telescope')
require('plugins.gitsigns')
require('plugins.git')
require('plugins.vim-easy-aline')
require('plugins.nvim-tree')

require('Comment').setup()
require('colorizer').setup()
-- require('go').setup()
