require('gitsigns').setup {
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Navigation
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})

    -- -- Actions
    map('n', '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>')
    map('v', '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>')
    map('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>')
    map('v', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>')

    map('n', '<leader>cb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')

    -- Text object
    map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
