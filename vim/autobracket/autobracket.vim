function! s:cursorIsBetween(before, after)
	let line = getline('.')
	let previousChar = line[col('.')-2]
	let nextChar = line[col('.')-1]
	return previousChar == a:before && nextChar == a:after
endfunction

function! s:enableAutoBracket()
	inoremap <buffer> { {}<Left>
	inoremap <buffer> <expr> <CR> <SID>cursorIsBetween('{','}') ? "<CR><Up><End><CR>" : "<CR>" 
endfunction

autocmd BufEnter *.java,*.json,*.js,*.ts call s:enableAutoBracket()
