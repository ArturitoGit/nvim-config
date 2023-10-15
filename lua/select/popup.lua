local events = require('select.events')
local utils = require('select.utils')
local setup_highlight = require('select.highlight')
local enable_infinite_scroll = require('select.infinite-scroll')

local function new_buffer(lines)
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
  return bufnr
end

local function new_win(buffer, lines)
  return vim.api.nvim_open_win(buffer, true, {
    row = 0,
    col = 0,
    height = #lines,
    width = utils.max_width(lines),
    border = "rounded",
    relative = "cursor",
    style = "minimal"
  })
end

local function new_popup(entries)
  local lines = utils.wrap_with(' ', entries)
  local buffer = new_buffer(lines)
  return {
    buffer = buffer,
    win = new_win(buffer, lines)
  }
end

local function set_unmodifiable(popup)
  vim.bo[popup.buffer].modifiable = false
end

local function open_popup(entries, on_select)
  local popup = new_popup(entries)

  setup_highlight(popup)
  enable_infinite_scroll(popup)
  set_unmodifiable(popup)

  events.on_select_line(popup, on_select)
  events.close_on({'q', '<Esc>'}, popup)
end

return open_popup
