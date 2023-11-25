return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local require_safe = require('utils').require_safe

    local telescope = require_safe('telescope')
    local actions = require_safe('telescope.actions')
    local builtin = require_safe('telescope.builtin')

    telescope.setup({
      defaults = {
        path_display = function(opts, path)
          local tail = require("telescope.utils").path_tail(path)
          return string.format("%s (%s)", tail, path), { { { 1, #tail }, "Constant" } }
        end,
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'bottom',
            preview_width = 0.42,
          },
        },
        sorting_strategy = 'ascending',

        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension('fzf')
    telescope.load_extension('live_grep_args')

    vim.keymap.set(
    'n',
    '<leader>p',
    ":lua require('telescope.builtin').find_files({ hidden = true })<CR>",
    {}
    )
    vim.keymap.set('n', '<leader>o', builtin.current_buffer_fuzzy_find, {})
    vim.keymap.set('n', '<leader>r', builtin.buffers, {})
    vim.keymap.set('n', '<leader>;', builtin.resume, {})
    vim.keymap.set('n', '\\', ':Telescope live_grep_args<CR>', {})
    vim.keymap.set('n', '|', builtin.grep_string, {})
  end
}
