local ts = require('java.methods.ts_utils')

local function parse_privacy(modifiers)
  local privacies = {
    { name = "protected", symbol = "~" },
    { name = "private", symbol = "-" },
    { name = "public", symbol = "+" },
    { name = "package", symbol = "o" }}

  for _, privacy in pairs(privacies) do
    if string.find(modifiers, privacy.name)  then
      return privacy.symbol
    end
  end

  return privacies[1].symbol
end

local function parse_parameters(params_node, buffer)
  local query = ts.query("(formal_parameters (formal_parameter (identifier) @param_name))")
  local target = { buffer = buffer, node = params_node }

  local params = {}
  for _, node in ts.execute(query, target) do
    local param_name = vim.treesitter.get_node_text(node, buffer)
    table.insert(params, param_name)
  end

  return params
end

local function parse_method(method_node, buffer)

  local query = ts.query([[(method_declaration
    (modifiers) @method_modifiers
    (identifier) @method_name
    (formal_parameters) @method_parameters
  )]])
  local target = { buffer = buffer, node = method_node }

  local method = {
    buffer = buffer,
    row = nil,
    col = nil,
    name = "?",
    privacy = " ",
    parameters = {}
  }

  for id, node in ts.execute(query, target) do
    local name = query.captures[id]
    local content = vim.treesitter.get_node_text(node, buffer)
    if (name == "method_name") then
      local row, col = node:range()
      method.name = content
      method.row = row + 1
      method.col = col + 1
    elseif (name == "method_modifiers") then
      method.privacy = parse_privacy(content)
    elseif (name == "method_parameters") then
      method.params = parse_parameters(node, buffer)
    end
  end

  return method
end

local M = {}

M.find_methods = function(buffer)
  local query = ts.query("(method_declaration) @method")

  local methods = {}
  for _, node in ts.execute(query, { buffer = buffer }) do
    table.insert(methods, parse_method(node, buffer));
  end

  return methods
end

return M
