-- Test current file
vim.keymap.set('n', '<A-t>', [[:vsplit | term nvim --headless -c 'PlenaryBustedFile %'<CR>]])
