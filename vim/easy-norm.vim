"
" Enhance usage of norm ex command, by providing an operator (gn) similar to the ! operator
"
" Ex :
" 	- "gn" in visual mode will fill the command line with ":'<'>norm! "
" 	- "gnj" in normal mode will fill the command line with ":.,.+1norm! "
" 	- "gnl" in norm mode will fill the command line with ":'[,']norm! ", which
"	  allows one to act on the last edited section

function! RelativeToCursor(line)
	let cursor_line = line(".")
	if (a:line == cursor_line)
		return "."
	elseif (a:line < cursor_line)
		return ".-"..(cursor_line - a:line)
	elseif (a:line > cursor_line)
		return ".+"..(a:line - cursor_line)
	endif
endfunction

function! FillNorm(_)
	let start = RelativeToCursor(line("'["))
	let end = RelativeToCursor(line("']"))
	let range = start..","..end
	call feedkeys(":"..range.."norm! ")
endfunction

nnoremap gn <Cmd>let &opfunc=function('FillNorm')<CR>g@
nnoremap gnl :'[,']norm!<Space>
vnoremap gn :norm!<Space>

"
" Enhance usage of @ command, by providing an operator(Q
"
" Ex :
" 	- "Qj" in normal mode will execute the macro q, as if one had used :.,.+1norm! @q
" 	- "Q" in visual mode will execute the q macro on each selected line, as if
" 	one had used :'<'>norm! @q

function RunMacro(_)
	let start = RelativeToCursor(line("'["))
	let end = RelativeToCursor(line("']"))
	let range = start..","..end
	call feedkeys(":"..range.."norm! @q\<CR>")
endfunction

nnoremap Q <Cmd> let &opfunc=function('RunMacro')<CR>g@
vnoremap Q :norm! @q<CR>
