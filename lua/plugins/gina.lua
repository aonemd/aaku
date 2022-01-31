vim.cmd([[
let g:gina#command#blame#formatter#format="%au: %su%=on %ti %ma%in"
call gina#custom#command#option('patch', '--oneside')
call gina#custom#command#option('patch', '--opener', 'edit')
]])
