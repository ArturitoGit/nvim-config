local function isListItemWithState(state)
  return function(line)
    local matcher = '^%s*- %['..state..'%]'
    return string.match(line, matcher) ~= nil
  end
end

local function replaceState(oldState, newState)
  return function(line)
    local oldPattern = '- %['..oldState..'%]'
    local newValue = '- ['..newState..']'
    return (string.gsub(line, oldPattern, newValue))
  end
end

local isAListItem = isListItemWithState('[x ]')
local isDisabled = isListItemWithState(' ')
local isEnabled = isListItemWithState('x')
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
  if not isAListItem(line) then return end
  vim.api.nvim_set_current_line(toggle(line))
end

-- Toggle list item state
vim.keymap.set('n', '<C-o>', toggleListElement)
