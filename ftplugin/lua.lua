local function create_exit_keymap(key)
  vim.keymap.set({ 'n', 't' }, key, '<Cmd>quit<CR>', { silent = true, buffer = true })
end

-- Test current file
vim.api.nvim_create_user_command('Test', function()

  -- Run tests
  vim.cmd('PlenaryBustedFile %')

  -- Quit window on q
  create_exit_keymap('q')
  create_exit_keymap('<Esc>')

end, {})
