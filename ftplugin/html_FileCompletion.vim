inoremap <buffer> <script> <expr> <Plug>(HtmlFileComplete) ft#html#FileCompletion#Expr()
if ! hasmapto('<Plug>(HtmlFileComplete)', 'i')
    imap <buffer> <C-x><C-f> <Plug>(HtmlFileComplete)
    let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin . '|' : '') . 'iunmap <buffer> <C-x><C-f>'
endif
