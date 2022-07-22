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

vim.cmd [[
" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <C-t> :call TermToggle(12)<CR>
inoremap <C-t> <Esc>:call TermToggle(12)<CR>
tnoremap <C-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :qq <C-\><C-n>:q!<CR>
]]

require("hotpot")
local _neato = require('is_neat')
-- neato("fennel") -- => "fennel is neat!"
