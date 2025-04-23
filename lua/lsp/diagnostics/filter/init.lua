-- Provide a generic way to filter LSP diagnostics, based on their source and code
--
-- Example :
--
-- require('diagnostics.filter').on {
--      ['typescript'] = {
--              { code = 7016 }
--      }
-- }
--
-- This exemple will filter diagnostics with code 7016, from typescript server

---@alias ServerRule { code: integer }
---@alias Rules table<string, ServerRule>

local function filter(array, condition)
  local filtered = {}
  for _, value in pairs(array) do
    if condition(value) then
      table.insert(filtered, value)
    end
  end
  return filtered
end

local function none_of(array, condition)
  for _, value in pairs(array) do
    if condition(value) then
      return false
    end
  end
  return true
end

local function matches(diag)
  return function(rule)

    -- Check optional code
    if rule.code and diag.code == rule.code then
      return true
    end

    -- Default
    return false
  end
end

--- Build filter function,
--- which can be used to determine if a diagnostics should be kept
---@param rules Rules to apply
---@return fun(lsp.Diagnostic): boolean
local function validate_with(rules)
  return function(diag)
    local server_rules = rules[diag.source]
    if not server_rules then
      return true
    end
    return none_of(server_rules, matches(diag))
  end
end

local M = {}

--- Filter LSP diagnostics according to provided configuration
--- @param rules Rules
M.filter_diags = function(rules)

  local handlers = vim.lsp.handlers
  local diagnostics = "textDocument/publishDiagnostics";
  local old = handlers[diagnostics]

  handlers[diagnostics] = function(a, result, ctx, config)
    result.diagnostics = filter(result.diagnostics, validate_with(rules))
    old(a, result, ctx, config)
  end
end

return M
