local separator = require('awk.separator')

local function any_match(expression, patterns)
  for _, pattern in pairs(patterns) do
    if expression:match(pattern) then
      return true
    end
  end
  return false
end

local function has_scope(script)
  local scoped_patterns = {
    '^%s*1%s*',
    '^%s*BEGIN',
    '^%s*{',
    '^%s*%('
  }

  return any_match(script, scoped_patterns)
end

local function fix_script(script)
  if not has_scope(script) then
    return '{ '..script..' }'
  end
  return script
end

local function awk(input, script)
  local command = { 'awk', '-F'..separator(), fix_script(script) }
  local result = vim.fn.system(command, input)
  if vim.v.shell_error ~= 0 then
    return nil
  end
  return result
end

return awk
