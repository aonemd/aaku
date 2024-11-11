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
  { import = 'plugins.conform' },
  { import = 'plugins.nvim-tree' },
  { import = 'plugins.gitsigns' },
  { import = 'plugins.fold' },
  'rktjmp/hotpot.nvim',
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    opts = {
      debug = false, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
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
      require 'eyeliner'.setup {
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
      }
    end
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
    event = 'VeryLazy',
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
  {
    'OXY2DEV/markview.nvim',
    -- lazy = false, -- Recommended
    ft = 'markdown', -- If you decide to lazy-load anyway
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- COLORSCHEMES
  {
    'rebelot/kanagawa.nvim',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  { 'catppuccin/nvim',           as = 'catppuccin', lazy = false, priority = 1000 },
  { 'aonemd/kuroi.vim',          lazy = false },
  { 'aonemd/quietlight.vim',     lazy = false },
  { 'B4mbus/oxocarbon-lua.nvim', lazy = false },
  { 'oxfist/night-owl.nvim',     lazy = false },
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
