local function separator()
  local type = vim.o.filetype
  if (type == 'csv_semicolon') then
    return ';'
  elseif (type == 'tsv') then
    return '\t'
  else
    return ';'
  end
end

local function lines(expression)
  return string.gmatch(expression, "[^\r\n]+")
end

local function currentFileName()
  return vim.fn.expand('%')
end

local function escapeSingleQuotes(expression)
  return string.gsub(expression, "'", '"')
end

local function runAwk(script)
  local commandLine = string.format("awk -F'%s' '%s' %s",
    separator(),
    escapeSingleQuotes(script),
    currentFileName()
  )

  return vim.fn.system(commandLine)
end

local function lastCommandFailed()
  return vim.v.shell_error ~= 0
end

local function either(value, default)
  if(#value <= 0) then
    return default
  else
    return value
  end
end

local function createAwkCommand(name, nargs, argsToScript)
  vim.api.nvim_create_user_command( name,
    function(c)
      local script = argsToScript(c.args)
      print(either(runAwk(script), 'No result...'))
    end,
    { nargs = nargs }
  )
end

-- Plain awk
createAwkCommand('Awk', '+', function(col)
  return col
end)

-- Find duplicated fields
createAwkCommand('Awkdup', 1, function(col)
  return "(++r["..col.."]==2){print "..col.."}"
end)

-- Get distinct colomn values
createAwkCommand('Awkdist', 1, function(col)
    return "(++r["..col.."]==1){print "..col.."}"
end)

local function renderLocListLine(line)
  return '|'..line.lnum..'|'..line.text
end

local function renderLocListItems(info)
  local r = {}

  local items = vim.fn.getloclist(
    info.winid,
    { id = info.id, items = true }
  ).items

  for i = info.start_idx, info.end_idx, 1 do
    table.insert(r, renderLocListLine(items[i]))
  end

  return r
end

local function createNewLocList(name)
  vim.fn.setloclist(0, {{ --[[ Empty --]] }})
  vim.fn.setloclist(0, {}, ' ', {
    title = name,
    quickfixtextfunc = renderLocListItems
  })
end

local function addToExistingLocList(item)
  vim.fn.setloclist(0, {}, 'a', { items = {item} })
end

local function locListItem(line)
  local spaceIdx = string.find(line, ' ')
  return {
    lnum = string.sub(line, 0, spaceIdx),
    text = string.sub(line, spaceIdx + 1),
    filename = currentFileName(),
  }
end

local function sendToLocationList(result, options)
  createNewLocList(options.as)

  for line in lines(result) do
    local item = locListItem(line)
    addToExistingLocList(item)
  end
end

vim.api.nvim_create_user_command('Awkq',
  function(c)
    local result = runAwk('('..c.args..'){ print NR" "$0 }')

    if (lastCommandFailed()) then
      print('Error...')
      print(result)
      return
    end

    if (#result <= 0) then
      print 'No result...'
      return
    end

    sendToLocationList(result, { as = '('..c.args..')' })
    print('Result available in location list !')
  end,
  { nargs = '+' }
)
