local parse = require('java.methods.parse')
local loc = require('java.methods.location_list')
local style = require('java.methods.style')

local function current_buffer()
  return vim.api.nvim_get_current_buf()
end

local function show_methods()
  local methods = parse.find_methods(current_buffer())

  if (#methods <= 0) then
    print("No method could be found...")
    return
  end

  loc.open_locations_of(methods)
end

style.colorize_method_loc_lists()
vim.api.nvim_create_user_command("Methods", show_methods, {})
