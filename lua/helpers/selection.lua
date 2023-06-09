local function lineOf(cursor)
  return cursor[2]
end

local function columnOf(cursor)
  return cursor[3]
end

local function getFullLinesBetween(firstLine, lastLine)
  return vim.api.nvim_buf_get_lines(0, firstLine - 1, lastLine, false)
end

local function mapFirstOf(array, map)
  array[1] = map(array[1])
end

local function mapLastOf(array, map)
  array[#array] = map(array[#array])
end

local function truncateAfter(index)
  return function(text)
    return string.sub(text, 0, index)
  end
end

local function truncateUntil(index)
  return function(text)
    return string.sub(text, index, -1)
  end
end

------
-- Main method
------
function LastSelection()

  local leftCursor = vim.fn.getpos("'<")
  local rightCursor = vim.fn.getpos("'>")
  local selectedLines = getFullLinesBetween(lineOf(leftCursor), lineOf(rightCursor))

  mapLastOf(selectedLines, truncateAfter(columnOf(rightCursor)))
  mapFirstOf(selectedLines, truncateUntil(columnOf(leftCursor)))

  return selectedLines
end
