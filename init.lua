local options    = {
  number         = true,
  relativenumber = true,
  hidden         = true,
  inccommand     = 'nosplit',
  hlsearch       = false,
  ignorecase     = true,
  smartcase      = true,
  mouse          = 'a',
  breakindent    = true,
  wrap           = false,
  updatetime     = 250,
  ttimeout       = true,
  ttimeoutlen    = 50  ,
  signcolumn     = 'yes',
  cursorline     = true ,
  colorcolumn    = '81' ,
  splitbelow     = true  ,
  splitright     = true  ,
  showtabline    = 0,
  clipboard      = "unnamedplus",
  completeopt    = { "menuone", "noselect" },
  shortmess      = vim.opt.shortmess + 'c',

  undofile       = true,   -- Save undo history
  writebackup    = false,  -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  swapfile       = false,  -- creates a swapfile
  backup         = false,  -- creates a backup file

  scrolloff      = 8,
  sidescrolloff  = 8,

  expandtab      = true,
  shiftwidth     = 2,
  tabstop        = 2,
  smartcase      = true,
  smartindent    = true,

  termguicolors = true,
  background    = 'dark',
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

require("keybindings")
require("plugins")
vim.cmd('source $HOME/.config/nvim/funks.vim')

vim.cmd [[colorscheme kuroi]]
require("statusline")

-- Highlight on yank (copy). It will do a nice highlight blink of the thing you just copied.
require("utils").create_augroup({
  {'TextYankPost', '*', 'silent! lua vim.highlight.on_yank()'}
}, 'YankHighlight')

-- Set colorscheme for macOS
local theme = vim.fn.system("defaults read -g AppleInterfaceStyle")
if theme and (string.find(theme, 'Light')) then
	vim.o.background = 'light'
	vim.cmd [[colorscheme quietlight]]
else
	vim.o.background = 'dark'
	vim.cmd [[colorscheme kuroi]]
end
