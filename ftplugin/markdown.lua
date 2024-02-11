local toggleListElement = require('markdown.toggle_list')
local putListPointAfter = require('markdown.auto_list_point')

putListPointAfter('o', 'n')
putListPointAfter('O', 'n')
putListPointAfter('<CR>', 'i')

vim.keymap.set('n', '<C-o>', toggleListElement, { buffer=true })

vim.cmd('setl conceallevel=2 concealcursor=n')
