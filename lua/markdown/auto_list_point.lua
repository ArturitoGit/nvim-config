local common = require('markdown.common')

local function putListPointAfter(key, mode)
  vim.keymap.set(mode, key,
    function()
      local line = vim.api.nvim_get_current_line()
      if common.isAListItem(line) then
        return key..'- [ ] '
      else
        return key
      end
    end,
    { expr = true, replace_keycodes = true }
  )
end

return putListPointAfter
