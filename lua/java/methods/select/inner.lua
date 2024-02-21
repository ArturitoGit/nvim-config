local ts = require('java.methods.ts_utils')

local function last_row_in(...)
  local _, _, row2 = ...
  return row2 + 1
end

local function cursor_is_in_or_after(node)
  local current_row = vim.api.nvim_win_get_cursor(0)[1]
  return current_row <= last_row_in(node:range())
end

local function range_of(node)
  local first_row, _, last_row = node:range()
  return {
    first = first_row + 1,
    last = last_row + 1
  }
end

local M = {}

M.method = function()
  local query = ts.query([[
    (method_declaration) @method
    (constructor_declaration) @constructor
  ]])
  for _, node in ts.execute(query) do
    if cursor_is_in_or_after(node) then
      return range_of(node)
    end
  end
end

return M
