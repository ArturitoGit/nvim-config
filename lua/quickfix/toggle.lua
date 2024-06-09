local function windows_open_in_current_tab()
  return vim.api.nvim_tabpage_list_wins(0)
end

local function is_quickfix(window)
  local buffer = vim.api.nvim_win_get_buf(window)
  local filetype = vim.bo[buffer].filetype
  return filetype == "qf"
end

local function is_quickfix_open_in_current_tab()
  for _, window in pairs(windows_open_in_current_tab()) do
    if is_quickfix(window) then
      return true
    end
  end
  return false
end

local function toggle_quickfix()
  if is_quickfix_open_in_current_tab() then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end

return toggle_quickfix
