local select = require('java.methods.select.select')
local inner = require('java.methods.select.inner')
local outer = require('java.methods.select.outer')
local java_keymap = require('java.methods.select.java_keymap')

vim.api.nvim_create_user_command('SelectInnerMethod', function()
  select.lines(inner.method())
end, {})

vim.api.nvim_create_user_command('SelectOuterMethod', function()
  select.lines(outer.method())
end, {})

java_keymap.set('o', 'im', ':SelectInnerMethod<CR>')
java_keymap.set('v', 'im', ':<C-u>SelectInnerMethod<CR>')
java_keymap.set('o', 'am', ':SelectOuterMethod<CR>')
java_keymap.set('v', 'am', ':<C-u>SelectOuterMethod<CR>')
