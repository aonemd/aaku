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

return M
