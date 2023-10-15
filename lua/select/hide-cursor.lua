vim.cmd('hi PopupCursor gui=reverse blend=100')

local function hide_cursor()
  -- vim.opt.guicursor:append("a:PopupCursor/PopupCursor")
  vim.opt.guicursor:append("n-v-ve-o:PopupCursor/PopupCursor")
end

local function show_cursor()
  -- vim.opt.guicursor:remove("a:PopupCursor/PopupCursor")
  vim.opt.guicursor:remove("n-v-ve-o:PopupCursor/PopupCursor")
end

return function(popup)
  hide_cursor()
  vim.api.nvim_create_autocmd({ "bufleave" }, {
    callback = show_cursor,
    buffer = popup.buffer
  })
end
