local inner = require('java.methods.select.inner')

local function line_content(index)
  return vim.api.nvim_buf_get_lines(0, index-1, index, true)[1]
end

local function is_empty(line)
  return string.match(line_content(line), "^$") ~= nil
end

local function last_empty_before(line)
  local current_line = line
  while current_line > 1 and is_empty(current_line-1) do
    current_line = current_line - 1
  end
  return current_line
end

local M = {}

M.method = function()
  local inner_method = inner.method()
  if inner_method == nil then return nil end
  return {
    first = last_empty_before(inner_method.first),
    last = inner_method.last
  }
end

return M
