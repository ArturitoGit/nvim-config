vim.cmd([[set shiftwidth=2 smarttab]])
vim.cmd([[set expandtab]])
vim.cmd([[set tabstop=8 softtabstop=0]])

-- Test current file
vim.keymap.set('n', '<A-t>', [[:vsplit | term nvim --headless -c 'PlenaryBustedFile %'<CR>]])
