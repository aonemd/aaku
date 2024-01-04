local keymap = vim.keymap.set

keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set(
  'n',
  '<leader>*',
  ':%s/\\<<c-r><c-w>\\>//g<left><left>',
  { desc = 'keymap: search and replace word under cursor' }
)

vim.cmd([[
  nnoremap ! :!
  nnoremap <leader>m :make<cr>

  "easily move between end of current line
  map H ^
  map L g_
  "toggle showing hidden characters
  nnoremap <silent> <leader>s :set nolist!<cr>
  "toggle spell checking
  nnoremap <leader>ss :setlocal spell!<cr>
  "toggle RTL mode
  nnoremap <silent> <leader>l :set arabic!<cr>
  "override system files by typing :w!!
  cnoremap w!! %!sudo tee > /dev/null %
  "remove search highlight
  nmap <leader>q :nohlsearch<CR>
  "execute and replace current line in $SHELL with the output
  nnoremap Q !!$SHELL<cr>
  "set cwd to the directory of the current file
  nnoremap <leader>cd :lcd %:p:h<cr>

  "move lines around
  nnoremap <leader>k :m-2<cr>==
  nnoremap <leader>j :m+<cr>==
  xnoremap <leader>k :m-2<cr>gv=gv
  xnoremap <leader>j :m'>+<cr>gv=gv

  "keep text selected after indentation
  vnoremap < <gv
  vnoremap > >gv

  nnoremap <leader>B :enew<cr>
  nnoremap <leader>bq :bp <bar> bd! #<cr>
  nnoremap <leader>ba :bufdo bd!<cr>
  "cycle between last two open buffers
  nnoremap <leader><leader> <c-^>
]])

vim.cmd([[
  "autoclose tags
  "()
  inoremap ( ()<Left>
  inoremap (<CR> (<CR>)<ESC>O
  inoremap (, (),<Left><Left>
  inoremap (,<CR> (<CR>),<ESC>O
  inoremap (; ();<Left><Left>
  inoremap (;<CR> (<CR>);<ESC>O
  inoremap (. ().<Left><Left>
  inoremap (.<CR> (<CR>).<ESC>O
  inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
  "{}
  inoremap { {}<Left>
  inoremap {<CR> {<CR>}<ESC>O
  inoremap {, {},<Left><Left>
  inoremap {,<CR> {<CR>},<ESC>O
  inoremap {; {};<Left><Left>
  inoremap {;<CR> {<CR>};<ESC>O
  "[]
  inoremap [ []<Left>
  inoremap [<CR> [<CR>]<ESC>O
  inoremap [, [],<Left><Left>
  inoremap [,<CR> [<CR>],<ESC>O
  inoremap [; [];<Left><Left>
  inoremap [;<CR> [<CR>];<ESC>O
  ""
  inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
]])

vim.cmd([[
  "move to the split in the direction shown, or create a new split
  nnoremap <silent> <C-h> :call WinMove('h')<cr>
  nnoremap <silent> <C-j> :call WinMove('j')<cr>
  nnoremap <silent> <C-k> :call WinMove('k')<cr>
  nnoremap <silent> <C-l> :call WinMove('l')<cr>
  function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
      if (match(a:key,'[jk]'))
        wincmd v
      else
        wincmd s
      endif
      exec "wincmd ".a:key
    endif
  endfunction

  "remove current line highlight in unfocused window
  autocmd! VimEnter,WinEnter,BufWinEnter,FocusGained,CmdwinEnter * set cul
  autocmd! WinLeave,FocusLost,CmdwinLeave * set nocul

  "smooth scroll
  nnoremap <silent> <c-u> :call SmoothScroll(1)<cr>
  nnoremap <silent> <c-d> :call SmoothScroll(0)<cr>
  function! SmoothScroll(up)
    execute "normal " . (a:up ? "\<c-y>" : "\<c-e>")
    redraw
    for l:count in range(3, &scroll, 2)
      sleep 7m
      execute "normal " . (a:up ? "\<c-y>" : "\<c-e>")
      redraw
    endfor
    " bring the cursor in the middle of screen
    execute "normal M"
  endfunction
]])

vim.cmd([[
  "netrw
  let g:netrw_banner=0
  let g:netrw_winsize=20
  let g:netrw_liststyle=3  "tree
  let g:netrw_localrmdir='rm -r'
  nnoremap <leader>n :Lexplore<CR>
  nnoremap <silent><leader>- :Lexplore %:h<CR><CR>
]])

vim.cmd([[
  "trailing whitespace
  function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
      let w:winview = winsaveview()
      %s/\(\s\+$\)\|\($\n\s*\)\+\%$//e
      if exists('w:winview') | call winrestview(w:winview) | endif
    endif
  endfunction

  function! SaveAuxiliary()
    :call StripTrailingWhitespace()
    :w
  endfunction
  nnoremap <leader>w :call SaveAuxiliary()<cr>
]])

vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true }) -- Y yank until the end of line  (note: this is now a default on master)

vim.cmd([[
"keep cursor centered on these ops
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

"break undo sequences on these chars
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") .'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") .'j'
]])
