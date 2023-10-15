local hide_cursor_in = require('select.hide-cursor')

vim.cmd([[
  hi PopupSelectedLine guifg=#81a1c2
  hi PopupBorder guifg=#81a1c1 guibg=NONE
  hi PopupFloat guibg=NONE
]])

local function set_filetype(filetype, popup)
  vim.api.nvim_buf_set_option(popup.buffer, 'filetype', filetype)
end

local function show_cursor_line(popup)
  vim.api.nvim_win_set_option(popup.win, "cursorline", true)
end

local function set_winhl(popup, map)
  local winhl = ''
  for old_grp, new_grp in pairs(map) do
    winhl = winhl..old_grp..':'..new_grp..','
  end
  vim.api.nvim_win_set_option(popup.win, "winhl", winhl)
end

local function setup_highlight(popup)
  set_filetype('CodeAction', popup)
  show_cursor_line(popup)
  hide_cursor_in(popup)
  set_winhl(popup, {
    CursorLine = 'PopupSelectedLine',
    NormalFloat = 'PopupFloat',
    FloatBorder = 'PopupBorder'
  })
end

return setup_highlight
