local separator = require('awk.separator')

local M = {}

local namespace_id = vim.api.nvim_create_namespace("AwkColumnHighlight")

M.find_all = function(target, pattern)
  local index = 0
  local results = {}
  while true do
    local found = target:find(pattern, index)
    if not found then
      break
    end
    table.insert(results, found)
    index = found + 1
  end

  return results
end

--- Get column boundaries in csv line
---@param col integer: The column to get
---@param line string: The line in which to search
---@param sep string?: The separator to use for columns, default is ;
---@return integer?: The column start index, nil if not found
---@return integer?: The column end index, nil if not found
M.find_column = function(col, line, sep)

  sep = sep or ';'

  if col <= 0 then
   return nil, nil
  end

  local column_positions = M.find_all(line, sep)
  table.insert(column_positions, #line + 1)
  table.insert(column_positions, 1, 0)

  if #column_positions < col + 1 then
    return nil, nil
  end

  return column_positions[col] + 1, column_positions[col + 1]
end

--- Highlight provided column in current buffer
---@param col integer: The column to be highlighted
M.column = function(col)

  local buffer = 0
  local sep = separator()

  M.clear()

  local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
  for row, line in pairs(lines) do

    local col_start, col_end = M.find_column(col, line, sep)
    if col_start then
      vim.hl.range(buffer, namespace_id,
        'Substitute',
        { row - 1, col_start  - 1 },
        { row - 1, col_end - 1 }
      )
    end
  end
end

--- Drop column highlighting in current buffer
M.clear = function()
  vim.api.nvim_buf_clear_namespace(0, namespace_id, 0, -1)
end

return M
