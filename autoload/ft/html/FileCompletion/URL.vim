function! ft#html#FileCompletion#URL#GetType( url )
    if a:url =~# '^/'
	return 'abs'
    elseif a:url =~? '^[a-z+.-]\+:' " RFC 1738
	return 'full'
    else
	return 'rel'
    endif
endfunction
