return {
  { 'L3MON4D3/LuaSnip', keys = {} },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    -- event = "InsertEnter",
    version = '*',
    config = function()
      -- vim.cmd('highlight Pmenu guibg=none')
      -- vim.cmd('highlight PmenuExtra guibg=none')
      -- vim.cmd('highlight FloatBorder guibg=none')
      -- vim.cmd('highlight NormalFloat guibg=none')

      require('blink.cmp').setup({
        snippets = { preset = 'luasnip' },
        signature = { enabled = true },
        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = 'normal',
        },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
          providers = {
            lazydev = {
              name = 'LazyDev',
              module = 'lazydev.integrations.blink',
              score_offset = 100,
            },
            cmdline = {
              min_keyword_length = 2,
            },
          },
        },
        keymap = {
          ['<C-f>'] = {},
          ['<c-q>'] = { 'hide', 'fallback' },
          ['<c-j>'] = { 'select_next', 'fallback' },
          ['<c-k>'] = { 'select_prev', 'fallback' },
          ['<c-m>'] = { 'select_and_accept', 'fallback' },
          ['<c-n>'] = { 'select_next', 'show', 'fallback' },
          ['<c-p>'] = { 'select_prev', 'fallback' },
          ['<cr>'] = { 'select_and_accept', 'fallback' },
        },
        cmdline = {
          enabled = false,
          completion = { menu = { auto_show = true } },
          keymap = {
            ['<CR>'] = { 'accept_and_enter', 'fallback' },
          },
        },
        completion = {
          menu = {
            border = nil,
            scrolloff = 1,
            scrollbar = false,
            draw = {
              columns = {
                { 'kind_icon' },
                { 'label', 'label_description', gap = 1 },
                { 'kind' },
                { 'source_name' },
              },
            },
          },
          documentation = {
            window = {
              border = nil,
              scrollbar = false,
              winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
            },
            auto_show = true,
            auto_show_delay_ms = 500,
          },
        },
      })

      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
}
