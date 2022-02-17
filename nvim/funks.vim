function Scratch(...)
    execute 'tabnew '
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile

    let ftype = get(a:, 1, 'scratchbuffer')
    execute 'setlocal filetype=' . ftype
endfunction

command! -nargs=1 Scratch call Scratch()
