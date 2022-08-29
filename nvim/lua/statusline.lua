vim.api.nvim_exec(
[[
  hi StatusLineModeNormalColor   guibg=NONE
  hi StatusLineModeInsertColor   guibg=#7fbfff
  hi StatusLineModeVisualColor   guibg=#7fbf7f
  hi StatusLineModeReplaceColor  guibg=#df7f9e
  hi StatusLineModeTerminalColor guibg=NONE
  hi StatusLineModeDefaultColor  guibg=NONE ctermbg=NONE

  "hi FilePathClearColor guifg=#c5c8c6 guibg=#262626 ctermbg=168 ctermfg=168
]], false)

local mode_color_map = {
  ['n']  = '%#StatusLineModeNormalColor# %*',
  ['i']  = '%#StatusLineModeInsertColor# %*',
  ['v']  = '%#StatusLineModeVisualColor# %*',
  ['V']  = '%#StatusLineModeVisualColor# %*',
  ['^V'] = '%#StatusLineModeVisualColor# %*',
  ['R']  = '%#StatusLineModeReplaceColor# %*',
  ['r']  = '%#StatusLineModeTerminalColor# %*',
  ['c']  = '%#StatusLineModeTerminalColor# %*',
  ['!']  = '%#StatusLineModeTerminalColor# %*',
  ['nt'] = '%#StatusLineModeTerminalColor# %*',
}

local function get_mode()
  local m = vim.api.nvim_get_mode().mode
  local active_window =
    vim.api.nvim_get_var('statusline_winid') == vim.fn.win_getid(vim.fn.winnr())

  if active_window then
    return mode_color_map[m] or '%#StatusLineModeDefaultColor# %*'
  else
    return ' '
  end
end

function _G.set_statusline()
  local blocks = {
    get_mode(),
    ' ',
    '%#FilePathClearColor#%f%*',
    '%=',
    '%m',
    ' ',
    '%c',
    ' ',
    '%P',
  }

  return table.concat(blocks)
end

vim.o.statusline = "%!v:lua.set_statusline()"
