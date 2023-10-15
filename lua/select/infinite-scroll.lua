local utils = require('select.utils')

local function height_of(popup)
  return vim.api.nvim_win_get_height(popup.win)
end

local function current_cursor_position(popup)
  return unpack(vim.api.nvim_win_get_cursor(popup.win))
end

local function set_row(get_next_row)
  return function(popup)
    local row, col = current_cursor_position(popup)
    local next_row = get_next_row(row, height_of(popup))
    vim.api.nvim_win_set_cursor(popup.win, { next_row, col })
  end
end

local function next_or_first(current, height)
  return current == height and 1 or current + 1
end

local function previous_or_last(current, height)
  return current == 1 and height or current - 1
end

-- Infinite scroll
return function(popup)
  utils.add_keymap(popup, 'k', set_row(previous_or_last))
  utils.add_keymap(popup, 'j', set_row(next_or_first))
end
