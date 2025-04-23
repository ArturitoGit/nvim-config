function! s:maximize(count)

	" If count is provided, fall back to default binding
	if (a:count != 0)
		exec "norm! ".a:count."\<C-w>_"
		return
	endif

	" Toggle ON : save current height & maximize window
	if !exists("w:previous_size")
		let w:previous_size = winheight(0)
		exec "norm! \<C-w>_"

	" Toggle OFF : restore previous height & forget it
	else
		exec "norm! ".w:previous_size."\<C-w>_"
		unlet w:previous_size
	endif

endfunction

" Remap native <C-w>_ key binding
command! -count Maximize call s:maximize(<count>)
nnoremap <silent> <C-w>_ :<C-u>exec v:count.'Maximize'<CR>
