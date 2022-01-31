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

  -- use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'ibhagwan/fzf-lua' }

  use {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"} -- Highlight, edit, and navigate code using a fast incremental parsing library. Treesitter is used by nvim for various things, but among others, for syntax coloring. Make sure that any themes you install support treesitter!
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- Additional textobjects for treesitter.

  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin.
  use 'hrsh7th/cmp-buffer' -- Autocompletion plugin.
  use 'hrsh7th/cmp-path' -- Autocompletion plugin.
  use 'hrsh7th/cmp-cmdline' -- Autocompletion plugin.
  use 'hrsh7th/cmp-nvim-lsp' -- Provide completions from LSP
  use 'saadparwaiz1/cmp_luasnip' -- Snippet completion
  -- snippets
  use 'L3MON4D3/LuaSnip' -- Snippets plugin, snippet enginer LOL
  use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  use 'lambdalisue/gina.vim'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- use 'b3nj5m1n/kommentary'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use 'machakann/vim-sandwich'
  use 'junegunn/vim-easy-align'

  use 'bluz71/vim-moonfly-colors' -- A theme I particularly like.
  -- use { 'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'} } -- A bar that will show at the top of you nvim containing your open buffers. Similarly to how other editors show tabs with open files.
  -- use 'itchyny/lightline.vim' -- Fancier status line with some information that will be displayed at the bottom.
  use 'aonemd/kuroi.vim'
  use 'aonemd/quietlight.vim'
end)

-- luasnip setup (you can leave this here or move it to its own configuration file in `lua/plugs/luasnip.lua`.)
luasnip = require 'luasnip'

require("plugins.cmp")
require("plugins.lsp")
require("plugins.treesitter")
-- require("plugins.telescope")
require("plugins.fzf")
require("plugins.gina")
require("plugins.gitsigns")
require("plugins.vim-easy-aline")

require('Comment').setup()
