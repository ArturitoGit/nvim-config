" Diff file

function ShowDiffFile()
	let file_name = matchstr(getline("."), '\S*$')
	let commit = matchstr(getline(1), '^commit \zs.*$')

	if empty(file_name) || empty(commit)
		return
	endif

	let child = FugitiveFind(commit. ':'.file_name)
	let parent = FugitiveFind(commit.'^:'.file_name)

	exe 'silent only'
	exe 'below Gsplit '.parent
	exe 'Gvdiffsplit '.child
endfunction

" Enable feature as dv keymap in git files
autocmd FileType git nnoremap <silent> <buffer> dv :<C-u>call ShowDiffFile()<CR>

" Fold content of fugitive commit file
function! GitShowFoldExpr()
  let l = getline(v:lnum)
  if l =~ '^diff --git '
    return '>1'
  elseif v:lnum > 1 && getline(v:lnum - 1) =~ '^diff --git '
    return '='
  elseif getline(v:lnum + 1) =~ '^diff --git '
    return '<1'
  else
    return '='
  endif
endfunction

function! GitShowFoldText()
  let start = v:foldstart
  let end = v:foldend
  let file_line = getline(start)
  " Extraire le chemin du fichier depuis la ligne "diff --git a/... b/..."
  let file = matchstr(file_line, '^diff --git a/\zs[^ ]\+')
  " Parcourir les premières lignes du fold pour détecter le type de changement
  let status = ''
  for lnum in range(start, min([start + 4, end]))
    let line = getline(lnum)
    if line =~ '^new file mode'
      let status = '[+] '
      break
    elseif line =~ '^deleted file mode'
      let status = '[-] '
      break
    endif
  endfor
  return '> ' . status . file
endfunction

augroup GitShowFolds
  autocmd!
  autocmd FileType git setlocal foldmethod=expr
        \ foldexpr=GitShowFoldExpr()
        \ foldtext=GitShowFoldText()
        \ foldlevel=0
augroup END

nnoremap <Leader>b :<C-u>G blame --date=short<CR>
