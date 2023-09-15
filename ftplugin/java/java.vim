inoremap <expr> <CR> getline(".") =~ "{$" ? "<CR>}<Up><End><CR>" : "<CR>"
