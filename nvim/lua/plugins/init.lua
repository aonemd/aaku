local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

require("utils").create_augroup({
  { 'BufWritePost */lua/plugins/init.lua source <afile> | PackerSync' }
}, 'Packer')

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use { 'ibhagwan/fzf-lua' }

  use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/nvim-treesitter-context'

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
  use  "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "tamago324/nlsp-settings.nvim"      -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim"   -- for formatters and linters

  use "rktjmp/hotpot.nvim"

  use({
    'dinhhuy258/git.nvim',
    config = function()
      require('git').setup({
        keymaps = {
          -- Open blame window
          blame = "<Leader>gb",
          -- Open file/folder in git repository
          browse = "<Leader>go",
        }
      })
    end
  })
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use 'machakann/vim-sandwich'
  use 'junegunn/vim-easy-align'
  use({
    "Pocco81/true-zen.nvim",
    config = function()
      require("true-zen").setup {
        -- your config goes here
        -- or just leave it empty :)
      }
    end,
  })
  use 'norcalli/nvim-colorizer.lua'
  use 'tpope/vim-eunuch'
  use 'vim-crystal/vim-crystal'
  use 'hashivim/vim-terraform'
  use 'udalov/kotlin-vim'
  use({
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  })
  use 'MunifTanjim/prettier.nvim'

  use 'aonemd/kuroi.vim'
  use 'aonemd/quietlight.vim'
  use 'B4mbus/oxocarbon-lua.nvim'
end)

luasnip = require 'luasnip'
require("plugins.cmp")
require("plugins.lsp")
require("plugins.null-ls")
require("plugins.treesitter")
require("plugins.fzf")
require("plugins.gitsigns")
require("plugins.vim-easy-aline")
require("plugins.prettier")

require('Comment').setup()
require 'colorizer'.setup()
