local function isListItemWithState(state)
  return function(line)
    local matcher = '^%s*- %['..state..'%]'
    return string.match(line, matcher) ~= nil
  end
end

local isAListItem = isListItemWithState('[x ]')

return {
  isListItemWithState = isListItemWithState,
  isAListItem = isAListItem
}
