syn match question '^\s*(?).*$'
syn match warning '/!\\'

syn match listTodoElement '^\s*- \[ \] .*$'
syn match listDoneElement '^\s*- \[x\] .*$'

hi question guifg=#81a1ca gui=italic
hi warning guifg=#d08f70 "Orange

" Unchecked list elements
hi link @text.todo.checked.markdown Comment
hi link listDoneElement Comment

" Underline title 1
hi @text.title.1.markdown gui=italic,underline
hi @text.title.1.marker.markdown gui=italic,underline
