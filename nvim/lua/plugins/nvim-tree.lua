return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require('nvim-tree').setup({
      sort_by = 'case_sensitive',
      sync_root_with_cwd = false,
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      view = {
        width = 40,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })

    local map_key = require('utils').map_key

    map_key('n', '<leader>n', ':NvimTreeToggle<CR>', { desc = 'nvim-tree: toggle tree' })
    map_key(
      'n',
      '<leader>-',
      ':NvimTreeToggle %:h<CR>',
      { desc = 'nvim-tree: toggle tree in current file directory' }
    )
  end,
}
