local M = {}

---@class CurrentTextOptions
---@field take? integer: The maximum number of lines to take. Take them all by default

--- Get current buffer content as string
---@param opts? CurrentTextOptions Options
---@return string: The buffer content
M.current = function(opts)
  opts = opts or {}
  local count = opts.take or -1

  local lines = vim.api.nvim_buf_get_lines(0, 0, count, false)
  return vim.fn.join(lines, "\n")
end

--- Set buffer content as string
---@param buf integer: The buffer to edit
---@param text string: The desired buffer content
M.set = function(buf, text)
  local lines = vim.fn.split(text, "\n")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

return M
