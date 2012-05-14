function! s:CanonicalizeFilespec( filespec )
    return substitute(a:filespec, '\\', '/', 'g') . (isdirectory(a:filespec) ? '/' : '')
endfunction
function! s:FindFiles( base )
    return map(split(glob(a:base . '*'), "\n"), 's:CanonicalizeFilespec(v:val)')
endfunction
function! s:DetermineBaseDir()
    " TODO: Recurse upward until no *.html found.
endfunction
function! s:FindMatches( base )
    let l:base = a:base
    let l:baseUrl = ''
    if exists('b:baseurl') && ! empty(b:baseurl) && strpart(a:base, 0, len(b:baseurl)) ==# b:baseurl
	let l:baseUrl = b:baseurl
	let l:base = strpart(a:base, len(b:baseurl))
	if empty(l:base)
	    let l:base = '/'
	    let l:baseUrl = substitute(b:baseurl, '/$', '', '')
	endif
    endif

    let l:baseDirspec = ''
    if l:base =~# '^/'
	if ! exists('b:basedir')
	    call s:DetermineBaseDir()
	endif
	if exists('b:basedir')
	    let l:baseDirspec = substitute(substitute(b:basedir, '\\', '/', 'g'), '/$', '', '')
	endif
    endif
"****D echomsg '****' string(l:base)
    let l:decodedBase = subs#URL#Decode(l:base)
    if empty(l:baseDirspec)
	let l:files = s:FindFiles(l:decodedBase)
    else
	let l:files = map(s:FindFiles(l:baseDirspec . l:decodedBase), printf('strpart(v:val, %d)', len(l:baseDirspec)))
    endif

    return map(l:files, '{ "word": l:baseUrl . subs#URL#FilespecEncode(v:val), "abbr": l:baseUrl . v:val }')
endfunction
function! ft#html#FileCompletion#FileComplete( findstart, base )
    if a:findstart
	" Locate the start of the keyword.
	let l:startCol = searchpos('\f*\%#', 'bn', line('.'))[1]
	if l:startCol == 0
	    let l:startCol = col('.')
	endif
	return l:startCol - 1 " Return byte index, not column.
    else
	" Find matches starting with a:base.
	return s:FindMatches(a:base)
    endif
endfunction

function! ft#html#FileCompletion#Expr()
    set completefunc=ft#html#FileCompletion#FileComplete
    return "\<C-x>\<C-u>"
endfunction
