function s:countWindows()
	return len(tabpagebuflist())
endfunction

function s:toggleList(openCmd, closeCmd)
	let count = s:countWindows()
	execute a:openCmd
	let someWasOpen = s:countWindows() > count

	if !someWasOpen
		execute a:closeCmd
	endif
endfunction

function ToggleLoclist()
	call s:toggleList("lopen", "lclose")
endfunction

function ToggleQuickfix()
	call s:toggleList("copen", "cclose")
endfunction

nnoremap <silent> <Leader>m :call ToggleLoclist()<CR>
nnoremap <silent> <Leader>q :call ToggleQuickfix()<CR>
