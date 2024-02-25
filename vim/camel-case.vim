let s:upper = '[A-Z0-9]'
let s:word_start = '\<'
let s:symbol = '\S\&\W'
let s:first_symbol = '\%('.s:symbol.'\)\@<!'.s:symbol

let s:pattern = s:upper.'\|'.s:word_start.'\|'.s:first_symbol

func! CamelForward()
	call search(s:pattern)
endfunc

func! CamelBackward()
	call search(s:pattern, 'b')
endfunc

func! InnerCamel()
	call CamelForward()
	call CamelBackward()
	normal! v
	call CamelForward()
	normal! h
endfunc

func! EnableCamel()
	let b:camel=1
	noremap <buffer> <silent> w <Cmd>call CamelForward()<CR>
	noremap <buffer> <silent> b <Cmd>call CamelBackward()<CR>
	noremap <buffer> <silent> iw :<C-U>call InnerCamel()<CR>
	noremap <buffer> <silent> ie iw
endfunc

func! DisableCamel()
	let b:camel=0
	unmap <buffer> w
	unmap <buffer> b
	unmap <buffer> iw
	unmap <buffer> ie
endfunc

func! ToggleCamel()
	let current = get(b:, "camel", 0)
	if(current == 0)
		call EnableCamel()
		echo "Camel mode enabled"
	else
		call DisableCamel()
		echo "Camel mode disabled"
	endif
endfunc

com! ToggleCamel call ToggleCamel()
