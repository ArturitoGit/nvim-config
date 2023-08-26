set tabline=%!MyTabLine()

function! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))

		" select the highlighting
		if i + 1 == tabpagenr()
			let s ..= '%#TabLineSel#'
		else
			let s ..= '%#TabLine#'
		endif

		" the label is made by MyTabLabel()
		let s ..= ' %{MyTabLabel(' .. (i + 1) .. ')} '
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
	let s ..= '%#TabLineFill#%T'

	return s
endfunction

function! MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	let path = bufname(buflist[winnr - 1])
	if path == ''
		return '[vide]'
	elseif IsFugitive(path)
		return '[Git]'
	else
		" Print only the name of the file
		return fnamemodify(path, ':t')
	endif
endfunction

function! IsFugitive(name)
	let r = matchstr(a:name, 'fugitive')
	return !empty(r)
endfunction
