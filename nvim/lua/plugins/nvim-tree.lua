return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- -- set termguicolors to enable highlight groups
    -- vim.opt.termguicolors = true

    -- OR setup with some options
    require('nvim-tree').setup({
      sort_by = 'case_sensitive',
      sync_root_with_cwd = false,
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      view = {
        width = 37,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })

    vim.cmd([[
      nnoremap <leader>n :NvimTreeToggle<CR>
      nnoremap <silent><leader>- :NvimTreeToggle %:h<CR><CR>
    ]])
  end,
}
