local M = {}

---
-- Return an array, with provided arguments as elements.
-- Nil arguments are not part of the result.
-- Order is preserved.
M.filter_nil = function(...)
  local array = {}
  for _, value in pairs({...}) do
    if value ~= nil then
      table.insert(array, value)
    end
  end
  return array
end

--- Return nil if <value> is falsy
--- Otherwise, apply optional <transform> on <value>,
--- and return the result.
---@param value any
---@param transform function
---@return any
M.if_defined = function(value, transform)
  if not value then
    return nil
  end
  if type(transform) ~= 'function' then
    return value
  end
  return transform(value)
end

--- Return a function that takes a single string
--- as argument, and return it prefixed with <prefix>.
---@param prefix string
---@return function
M.prefix_it_with = function(prefix)
  return function(value)
    return prefix..value
  end
end

return M
