local M = {}

M.map = function(values, op)
  local res = {}
  for _, value in pairs(values) do
    table.insert(res, op(value))
  end
  return res
end

M.wrap_with = function(char, entries)
  return M.map(entries, function(entry)
    return char..entry..char
  end)
end

M.max_width = function(entries)
  local max = 0
  for _, value in pairs(entries) do
    local len = #value
    if len > max then max = len end
  end
  return max
end

M.add_keymap = function(popup, key, action)
  local callback

  if type(action) == 'string' then
    callback = action
  else
    callback = function()
      action(popup)
    end
  end

  vim.keymap.set('n', key, callback, { buffer = popup.buffer })
end

return M
