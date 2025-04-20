local separator = require('awk.separator')

local function has_scope(script)
  if string.match(script, "^%s*1%s*") then
    return true
  end
  if string.match(script, "^%s*BEGIN") then
    return true
  end
  if string.match(script, "^%s*{") then
    return true
  end
  return false
end

local function fix_script(script)
  if not has_scope(script) then
    return '{ '..script..' }'
  end
  return script
end

local function awk(input, script)
  local command = { 'awk', '-F'..separator(), fix_script(script) }
  local result = vim.system(command, { stdin = input }):wait()
  return result.stdout
end

return awk
