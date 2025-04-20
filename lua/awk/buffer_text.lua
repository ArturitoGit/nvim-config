local M = {}

M.current = function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  return vim.fn.join(lines, "\n")
end

M.set = function(buf, text)
  local lines = vim.fn.split(text, "\n")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

return M
