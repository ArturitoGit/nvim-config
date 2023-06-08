-- In normal mode, make numbers accessible without pressing SHIFT
vim.o.langmap=[[&1,é2,"3,'4,\(5,-6,è7,_8,ç9,à0,1&,2é,3",4',5\(,6-,7è,8_,9ç,0à]]

-- Fix "inner" commands
vim.keymap.set('n', 'vi3', 'vi"')
vim.keymap.set('n', 'ci3', 'ci"')
vim.keymap.set('n', 'di3', 'di"')
vim.keymap.set('n', 'va3', 'va"')
vim.keymap.set('n', 'ca3', 'ca"')
vim.keymap.set('n', 'da3', 'da"')

vim.keymap.set('n', 'vi4', "vi'")
vim.keymap.set('n', 'di4', "di'")
vim.keymap.set('n', 'ci4', "ci'")
vim.keymap.set('n', 'va4', "va'")
vim.keymap.set('n', 'da4', "da'")
vim.keymap.set('n', 'ca4', "ca'")

vim.keymap.set('n', 'vi5', "vi(")
vim.keymap.set('n', 'di5', "di(")
vim.keymap.set('n', 'ci5', "ci(")
vim.keymap.set('n', 'va5', "va(")
vim.keymap.set('n', 'da5', "da(")
vim.keymap.set('n', 'ca5', "ca(")
