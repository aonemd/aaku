vim.api.nvim_create_user_command('ShowGitLogOfSelectedLines', function()
  local range = vim.fn.line("'<") .. ',' .. vim.fn.line("'>")
  local file_path = vim.fn.expand('%')

  vim.cmd('G log -L ' .. range .. ':' .. file_path)
end, {})

vim.keymap.set(
  'v',
  '<Leader>gl',
  ':<C-U>ShowGitLogOfSelectedLines<CR>',
  { noremap = true, desc = 'Git history of selected lines' }
)
