local M = {}

M.query = function(expression)
  return vim.treesitter.query.parse("java", expression)
end

M.root = function(buffer)
  local parser = vim.treesitter.get_parser(buffer, "java", {})
  local tree = parser:parse()[1]
  return tree:root()
end

M.execute = function(query, target)

  if target == nil then
    target = {}
  end

  local buffer = target.buffer
  if buffer == nil then
    buffer = 0
  end

  local node = target.node
  if node == nil then
    node = M.root(buffer)
  end

  return query:iter_captures(node, buffer, 0, -1)
end

return M
