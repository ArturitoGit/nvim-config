-- Go to next Uppercase letter
vim.keymap.set('n', '<tab>', function() vim.fn.search('[A-Z]') end)
