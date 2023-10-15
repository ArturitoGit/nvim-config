local utils = require('select.utils')

local M = {}

local function quit(popup)
    vim.api.nvim_buf_delete(popup.buffer, {})
end

local function cursor_row(popup)
  return vim.api.nvim_win_get_cursor(popup.win)[1]
end

M.on_select_line = function(popup, callback)
  utils.add_keymap(popup, '<CR>', function()
    local row = cursor_row(popup)
    quit(popup)
    callback(row)
  end)
end

M.close_on = function(keys, popup)
  for _, key in pairs(keys) do
    utils.add_keymap(popup, key, quit)
  end
end

return M
