local function contains(elem, array)
  for _, value in pairs(array) do
    if value == elem then
      return true
    end
  end
  return false
end

local function remove(indices, elems)
  local result = {}
  for id, elem in pairs(elems) do
    if not contains(id, indices) then
      table.insert(result, elem)
    end
  end
  return result
end

local function current_qf()
  return vim.fn.getqflist({
    context = 0,
    items = 0,
    title = 0
  })
end

local function qf_remove_lines(indices)
  local new_qf = current_qf()
  new_qf.items = remove(indices, new_qf.items)
  vim.fn.setqflist({}, ' ', new_qf)
end

local function range_of(extremums)
  local first = extremums.first
  local last = extremums.last
  if first > last then return {} end
  local result = {}
  for i = first, last, 1 do
      table.insert(result, i)
  end
  return result
end

local function cursor_line()
  return vim.api.nvim_win_get_cursor(0)[1]
end

local function visual_selection()
  return {
    first = vim.api.nvim_buf_get_mark(0, '<')[1],
    last = vim.api.nvim_buf_get_mark(0, '>')[1]
  }
end

local function quickfix_is_active()
  return vim.bo[0].filetype == "qf"
end

local function quickfix_remove(range)
  if not quickfix_is_active() then
    print("You are not in a quickfix list !")
    return
  end
  qf_remove_lines(range)
end

local function create_qf_keymap(mode, key, action)
  vim.api.nvim_create_autocmd({"BufWinEnter"}, {
    pattern = "quickfix",
    callback = function()
      vim.keymap.set(mode, key, action, { buffer = 0, silent = true })
    end
  })
end

vim.api.nvim_create_user_command('QFRemove', function()
  quickfix_remove({cursor_line()})
end, {})

vim.api.nvim_create_user_command('QFRemoveRange', function()
  quickfix_remove(range_of(visual_selection()))
end, { range=true })

create_qf_keymap('v', '<Leader>x', ":<C-u>'<'>QFRemoveRange<CR>")
