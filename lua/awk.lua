local function runAwk(script)
  local filePath = vim.fn.expand('%')
  local commandLine = "awk -F';' '"..script.."' "..filePath
  local result = vim.fn.system(commandLine)

  if (#result <= 0) then
    print('No result ...')
    return
  end

  print(result)
end

local function createAwkCommand(name, nargs, argsToScript)
  vim.api.nvim_create_user_command( name,
    function(c)
      local script = argsToScript(c.args)
      runAwk(script)
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

--[[
--
-- Pour aller plus loin
--  * Déterminer le séparator à utiliser en fonction du typefile
--    csv_semicolon
--    csv
--    tsv etc
--
--]]
