local options    = {
  number         = true,
  relativenumber = true,
  hidden         = true,
  inccommand     = 'nosplit',
  hlsearch       = false,
  ignorecase     = true,
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

  expandtab   = true,
  shiftwidth  = 2,
  tabstop     = 2,
  softtabstop = 2,
  smartcase   = true,
  -- smartindent = true,
  -- autoindent  = true,

  termguicolors = true,

  grepprg = "rg --vimgrep --smart-case",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- `:Cfilter pattern` to filter entires in copen
-- more ideas https://gosukiwi.github.io/vim/2022/04/19/vim-advanced-search-and-replace.html
vim.cmd [[packadd! cfilter]]

require("keybindings")
require("plugins")
vim.cmd('source $HOME/.config/nvim/funks.vim')

require("terminal")
require("statusline")
require("funks")
SetTheme()

-- Highlight on yank (copy). It will do a nice highlight blink of the thing you just copied.
require("utils").create_augroup({
  {'TextYankPost', '*', 'silent! lua vim.highlight.on_yank()'}
}, 'YankHighlight')

vim.cmd [[
  augroup Markdown
    autocmd!
    autocmd FileType markdown set wrap linebreak
  augroup END
]]

require("hotpot")
local _neato = require('is_neat')
-- neato("fennel") -- => "fennel is neat!"
