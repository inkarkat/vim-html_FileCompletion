" log.vim: Supporting functions for the 'log' filetype. 
"
" DEPENDENCIES:
"   - ingoplugin.vim autoload script. 
"
" Copyright: (C) 2010-2011 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'. 
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS 
"	003	20-Mar-2011	Allow optional components in timestamp regexp by
"				enclosing them in \(...\) in
"				g:log_timestamp_format. This allows to remove
"				the time from my timestamp, and still have the
"				entry matched and folded properly. 
"	002	06-Jul-2010	Made timestamp format configurable. 
"	001	06-Jul-2010	file creation

function! ft#log#Timestamp()
    return strftime(substitute(ingoplugin#GetBufferLocalSetting('log_timestamp_format', '%c'), '\\[()]', '', 'g'))
endfunction
function! ft#log#TimestampRegexp()
    let l:regexp = strftime(ingoplugin#GetBufferLocalSetting('log_timestamp_format', '%c'))
    let l:regexp = substitute(l:regexp, '\a', '\\a', 'g')
    let l:regexp = substitute(l:regexp, '\d', '\\d', 'g')
    let l:regexp = substitute(l:regexp, '\\)', '\0\\?', 'g')
    return '\V' . l:regexp
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
