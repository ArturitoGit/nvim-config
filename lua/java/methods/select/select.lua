local M = {}

local function move_cursor_to(line)
  vim.api.nvim_win_set_cursor(0, { line, 0 })
end

M.lines = function(range)
  move_cursor_to(range.first)
  vim.cmd.normal("v")
  move_cursor_to(range.last)
  vim.cmd.normal("$")
end

return M
