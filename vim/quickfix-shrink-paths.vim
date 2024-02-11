" WITH CONCEAL
"
" \(^[^\/]*\)\@<=   The match should come after no "/" from the line beginning
" \/                The match should be a "/"
" \(.*\/\)\@=       The match should come before a "/" in the line
" Which matches : The first "/" in a line that contains several
" FIXME : All of it should not contain a "|"

" \(^[^\/]*\/\)\@<=     The match should come after this first "/" of a line
" .*
" \(\/[^\/]*|\)\@=      The match should come before the last "/" before a "|"
" Which matches : The content between the first and last "/", before a "|"
" FIXME : All of it should be before the first "|"

" autocmd BufWinEnter quickfix
" 	\ call matchadd('Conceal', '\(^[^\/]*\)\@<=\/\(.*\/\)\@=', 10, 99, { 'conceal': '.' }) |
" 	\ call matchadd('Conceal', '\(^[^\/]*\/\)\@<=.*\(\/[^\/]*|\)\@=', 10, 100, { 'conceal': '.' }) |
" 	\ highlight! link Conceal Directory |
" 	\ set conceallevel=2 concealcursor=nc

" WITH QUICKFIXTEXTFUNC
"
func Shrink(path)
	let pathElements = split(a:path, '/')

	let keepUnchanged = len(a:path) <= 20 || len(pathElements) <= 2
	if (keepUnchanged)
		return a:path
	endif

	let pathRoot = pathElements[0]
	let fileName = pathElements[len(pathElements) - 1]

	return pathRoot."/../".fileName
endfunc

func ShrinkQuickfixPaths(info)
	let items = getqflist({'id' : a:info.id, 'items' : 1}).items
	let l = []
	for idx in range(a:info.start_idx - 1, a:info.end_idx - 1)
		let item = items[idx]
		let path = Shrink(bufname(item.bufnr))
		let row = item.lnum
		let line = item.text
		call add(l, path.."|"..row.."| "..line)
	endfor
	return l
endfunc

set quickfixtextfunc=ShrinkQuickfixPaths
