local loc = require('java.methods.locate.locations')

local function on_enter_methods_location(callback)
  vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    pattern = { "quickfix" },
    callback = function()
      local loc_list = vim.fn.getloclist(0, { context = 0 })

      if (loc_list.context ~= loc.FIND_METHOD_CONTEXT) then
        return
      end

      callback(loc_list)
    end
  })
end

local M = {}

M.colorize_method_loc_lists = function()
  on_enter_methods_location(function()
    vim.fn.matchadd("Label", "^[+-o\\~]")
    vim.fn.matchadd("Function", [[\([+-o\~]\s*\)\@<=\w*]])
    vim.fn.matchadd("Identifier", [[(.*)]])
  end)
end

return M
