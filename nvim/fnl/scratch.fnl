(lambda scratch [opts]
  (local current-buffer 0)
  (local prev-buffer-filetype (vim.api.nvim_buf_get_option 0 "filetype"))
  (local filetype (if (= (length opts.args) 0) prev-buffer-filetype opts.args))

  (vim.api.nvim_command "enew")

  (vim.api.nvim_buf_set_option current-buffer "buftype"   "nofile")
  (vim.api.nvim_buf_set_option current-buffer "bufhidden" "hide")
  (vim.api.nvim_buf_set_option current-buffer "swapfile"  true)
  (vim.api.nvim_buf_set_option current-buffer "filetype"  filetype))

(vim.api.nvim_create_user_command "Scratch" scratch {:nargs "?"})
