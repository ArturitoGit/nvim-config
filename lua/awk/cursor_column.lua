local M = {}

--- Return column currently edited by <cursor> in <line>
--- Column has format "$i" with i an integer
---@param line string: The line to search column in
---@param cursor integer: The position of the cursor
---@return integer?: The currently edited column if found, nil otherwise
M.find_column_under_cursor = function(line, cursor)

  if not line then
    return nil
  end

  local before_cursor = line:sub(0, cursor)
  local after_cursor = line:sub(cursor + 1)

  local left_part = before_cursor:match('(%$%d*)$')
  local right_part = after_cursor:match('^(%$?%d*)')
  local column = (left_part or '') .. (right_part or '')

  return tonumber(column:match('^%$(%d+)$'))
end

--- Return column around cursor in command line
---@return integer?: The index of the column if found, nil otherwise
M.column_under_cursor = function()
  local line = vim.fn.getcmdline()
  local pos = vim.fn.getcmdpos()
  return M.find_column_under_cursor(line, pos)
end

return M
