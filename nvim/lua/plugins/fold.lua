return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  config = function()
    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    local map_key = require('utils').map_key

    map_key('n', '-', '<cmd>foldclose<CR>', { desc = 'fold: close fold' })
    map_key('n', '+', '<cmd>foldopen<CR>', { desc = 'fold: open fold' })
    map_key('n', 'zR', require('ufo').openAllFolds, { desc = 'fold: open all folds' })
    map_key('n', 'zM', require('ufo').closeAllFolds, { desc = 'fold: close all folds' })

    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { 'lsp', 'indent' }
      end,
    })
  end,
}
