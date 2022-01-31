require('fzf-lua').setup {
	grep = {
		input_prompt = 'Grep: '
	}
}

vim.api.nvim_set_keymap('n', '<leader>f', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>r', "<cmd>lua require('fzf-lua').buffers()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>o', "<cmd>lua require('fzf-lua').blines()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '\\', "<cmd>lua require('fzf-lua').grep()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '|', "<cmd>lua require('fzf-lua').grep_cword()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>x', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
