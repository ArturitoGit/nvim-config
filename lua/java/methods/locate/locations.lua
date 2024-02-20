local display = require('java.methods.locate.display')

local M = {}

M.FIND_METHOD_CONTEXT = "find_methods"

local function location_text_func(info)
  local items = vim.fn.getloclist(info.winid)
  local l = {}
  for i = info.start_idx, info.end_idx, 1 do
    local text = items[i].text
    table.insert(l, text)
  end

  return l
end

local function open_loc_window(locations)
  local window = vim.api.nvim_get_current_win()
  vim.fn.setloclist(window, {}, 'r', {
    title="Methods",
    context=M.FIND_METHOD_CONTEXT,
    items=locations,
    quickfixtextfunc=location_text_func
  })
  vim.cmd.lopen()
end

local function max_of(accessor, elements)
  local max
  for _, elem in pairs(elements) do
    local localMax = accessor(elem)
    if (max == nil or localMax > max) then
      max = localMax
    end
  end
  return max
end

local function name_size(method)
  return #method.name
end

local function locations_of(methods)
  local locations = {}
  local biggest_method_size = max_of(name_size, methods)

  for _, method in pairs(methods) do
    table.insert(locations, {
      bufnr=method.buffer,
      lnum=method.row,
      col=method.col,
      text=display.display_method(method, {
        methods_width=biggest_method_size
      })
    })
  end

  return locations
end

M.open_locations_of = function(methods)
  open_loc_window(locations_of(methods))
end

return M
