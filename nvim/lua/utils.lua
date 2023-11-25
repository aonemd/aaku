local M = {}

local cmd = vim.cmd
function M.create_augroup(autocmds, name)
  cmd('augroup ' .. name)
  cmd('autocmd!')
  for _, autocmd in ipairs(autocmds) do
    cmd('autocmd ' .. table.concat(autocmd, ' '))
  end
  cmd('augroup END')
end

function M.require_safe(name)
  local status_ok, module = pcall(require, name)
  if not status_ok then
    return
  end

  return module
end

function M.map_key(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }

  if opts then
    if opts.desc then
      opts.desc = 'keymaps.lua: ' .. opts.desc
    end
    options = vim.tbl_extend('force', options, opts)
  end

  vim.keymap.set(mode, lhs, rhs, options)
end

function M.map_key_buffer(mode, lhs, rhs, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  M.map_key(mode, lhs, rhs, bufopts)
end

return M
