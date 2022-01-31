local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use { 'ibhagwan/fzf-lua' }

  use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" }
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  use 'hrsh7th/nvim-cmp'          -- Autocompletion plugin.
  use 'hrsh7th/cmp-buffer'        -- Autocompletion plugin.
  use 'hrsh7th/cmp-path'          -- Autocompletion plugin.
  use 'hrsh7th/cmp-cmdline'       -- Autocompletion plugin.
  use 'hrsh7th/cmp-nvim-lsp'      -- Provide completions from LSP
  use 'saadparwaiz1/cmp_luasnip'  -- Snippet completion
  -- snippets
  use 'L3MON4D3/LuaSnip'             -- Snippets plugin, snippet "engine"
  use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig"             -- enable LSP
  use "williamboman/nvim-lsp-installer"   -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim"      -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim"   -- for formatters and linters

  use 'lambdalisue/gina.vim'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use 'machakann/vim-sandwich'
  use 'junegunn/vim-easy-align'

  use 'aonemd/kuroi.vim'
  use 'aonemd/quietlight.vim'
end)

luasnip = require 'luasnip'
require("plugins.cmp")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.fzf")
require("plugins.gina")
require("plugins.gitsigns")
require("plugins.vim-easy-aline")
require('Comment').setup()
