local function pad(expression, size)
  local result = expression
  while (#result < size) do
    result = result.." "
  end
  return result
end

local function join(elems, sep)
  local result = ""
  for idx, elem in pairs(elems) do
    if idx >= 2 then result = result..sep end
    result = result..elem
  end
  return result
end

local function display_params(method)
  if(#method.params <= 0) then
    return ""
  end
  return "( "..join(method.params, ", ").." )"
end

local M = {}

M.display_method = function(method, options)
  return (
    method.privacy.." "..
    pad(method.name, options.methods_width).." "..
    display_params(method)
  )
end

return M
