local M = {}

function M.require_safe(name)
  local status_ok, module = pcall(require, name)
  if not status_ok then
    return
  end

  return module
end

return M
