-- Key mapping
vim.keymap.set('n', '<Leader>t', ':TestLast<CR>')
vim.api.nvim_create_user_command('Tn', 'TestNearest', {})
vim.api.nvim_create_user_command('Tl', 'TestLast', {})
vim.api.nvim_create_user_command('Tf', 'TestFile', {})
vim.api.nvim_create_user_command('Tc', 'TestClass', {})
vim.api.nvim_create_user_command('Tv', 'TestVisit', {})
