-- https://teukka.tech/luanvim.html

local api = vim.api

local M = {}

function M.makeScratch()
  api.nvim_command('enew') -- equivalent to :enew
  vim.bo[0].buftype=nofile -- set the current buffer's (buffer 0) buftype to nofile
  vim.bo[0].bufhidden=hide
  vim.bo[0].swapfile=false
end

function _G.SetTheme()
  local filehandle    = io.open(os.getenv("HOME") .. "/.config/system-theme", "r")
  local current_theme = filehandle:read()
  filehandle:close()

  if current_theme == "dark" then
    vim.cmd([[
    set background=dark
    "colorscheme kuroi
    colorscheme oxocarbon-lua
    ]])
  else
    vim.cmd([[
    set background=light
    colorscheme quietlight
    ]])
  end

  -- reload statusline
  package.loaded['statusline'] = nil
  require("statusline")
end

function _G.ToggleTheme(mode)
  local _toggle_dark = function ()
    vim.cmd([[
    set background=dark
    "colorscheme kuroi
    colorscheme oxocarbon-lua
    ]])
  end

  local _toggle_light = function ()
    vim.cmd([[
    set background=light
    colorscheme quietlight
    ]])
  end

  if mode == "dark" then
    _toggle_dark()
  elseif mode == 'light' then
    _toggle_light()
  else
    local current_mode = vim.api.nvim_get_option('background')
    if current_mode == 'dark' then
      _toggle_light()
    else
      _toggle_dark()
    end
  end

  -- reload statusline
  package.loaded['statusline'] = nil
  require("statusline")
end

return M
