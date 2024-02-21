local utils = require('select.utils')
local open_popup = require('select.popup')

local function titles_in(entries)
  return utils.map(entries, function(entry)
    if (entry[2]) then
      return entry[2].title
    else
      return entry
    end
  end)
end

local function select(entries, _, callback)
  local displayed = titles_in(entries)
  local on_select = function(index)
    callback(entries[index])
  end
  open_popup(displayed, on_select)
end

-- Test popup
local function test()
  select(
    {
      {1, { title="Option 1" }},
      {1, { title="Option 2" }},
      {1, { title="Option 3" }},
      {1, { title="Option 4" }}
    },
    {},
    function(choice)
      vim.notify("Selected : "..choice[2].title)
    end
  )
end

-- Override default ui.select function
-- vim.ui.select = select

-- TODO : Handle second argument of select()
-- which contains a list of options
-- One option is { prompt: "some" }
-- This option should be implemented in order
-- for JdtWipeDataAndRestart to work
