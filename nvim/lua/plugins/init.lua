local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

require('utils').create_augroup({
  { 'BufWritePost */lua/plugins/init.lua source <afile> | PackerSync' },
}, 'Packer')

local use = require('packer').use
require('packer').startup(function()
  use('wbthomason/packer.nvim')

  use({
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  })

  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use('nvim-treesitter/nvim-treesitter-textobjects')
  use('nvim-treesitter/nvim-treesitter-context')

  use('hrsh7th/nvim-cmp') -- Autocompletion plugin.
  use('hrsh7th/cmp-buffer') -- Autocompletion plugin.
  use('hrsh7th/cmp-path') -- Autocompletion plugin.
  use('hrsh7th/cmp-cmdline') -- Autocompletion plugin.
  use('hrsh7th/cmp-nvim-lsp') -- Provide completions from LSP
  use('saadparwaiz1/cmp_luasnip') -- Snippet completion
  -- snippets
  use('L3MON4D3/LuaSnip') -- Snippets plugin, snippet "engine"
  use('rafamadriz/friendly-snippets') -- a bunch of snippets to use

  -- LSP
  use('neovim/nvim-lspconfig') -- enable LSP
  use('williamboman/mason.nvim')
  use('williamboman/mason-lspconfig.nvim')
  -- use "jose-elias-alvarez/null-ls.nvim"   -- for formatters and linters
  use('nvimdev/guard.nvim')

  use('rktjmp/hotpot.nvim')

  use({ 'dpayne/CodeGPT.nvim', requires = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim' } })

  use('tpope/vim-fugitive')
  use({
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
  })
  use({ 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } })
  use('JoosepAlviste/nvim-ts-context-commentstring')
  use({
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  })
  use('machakann/vim-sandwich')
  use('junegunn/vim-easy-align')
  use({
    'Pocco81/true-zen.nvim',
    config = function()
      require('true-zen').setup({
        -- your config goes here
        -- or just leave it empty :)
      })
    end,
  })
  use('norcalli/nvim-colorizer.lua')
  use({
    'chrisgrieser/nvim-genghis',
    requires = {
      'stevearc/dressing.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-omni',
    },
  })
  use('aonemd/kuroi.vim')
  use('aonemd/quietlight.vim')
  use('B4mbus/oxocarbon-lua.nvim')
  use('rebelot/kanagawa.nvim')
  use({ 'catppuccin/nvim', as = 'catppuccin' })
  use('mfussenegger/nvim-jdtls')
  use({
    'pmizio/typescript-tools.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  })
  use({
    'iamcco/markdown-preview.nvim',
    run = function()
      vim.fn['mkdp#util#install']()
    end,
  })
end)

require('plugins.cmp')
require('plugins.lsp')
-- require("plugins.null-ls")
require('plugins.guard')
require('plugins.treesitter')
require('plugins.telescope')
require('plugins.gitsigns')
require('plugins.git')
require('plugins.vim-easy-aline')

require('Comment').setup()
require('colorizer').setup()
