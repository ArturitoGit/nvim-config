-- Test current file
vim.api.nvim_create_user_command('Tn', [[:vsplit | term nvim --headless -c 'PlenaryBustedFile %'<CR>]], {})
