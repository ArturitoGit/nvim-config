local common = require('markdown.common')

local function replaceState(oldState, newState)
  return function(line)
    local oldPattern = '- %['..oldState..'%]'
    local newValue = '- ['..newState..']'
    return (string.gsub(line, oldPattern, newValue))
  end
end

local isDisabled = common.isListItemWithState(' ')
local isEnabled = common.isListItemWithState('x')
local enable = replaceState(' ', 'x')
local disable = replaceState('x', ' ')

local function toggle(listItem)
  if isDisabled(listItem) then
    return enable(listItem)
  elseif isEnabled(listItem) then
    return disable(listItem)
  end
end

local function toggleListElement()
  local line = vim.api.nvim_get_current_line()
  if not common.isAListItem(line) then return end
  vim.api.nvim_set_current_line(toggle(line))
end

return toggleListElement
