local function ts_query(expression)
  return vim.treesitter.query.parse("java", expression)
end

local function root(buffer)
  local parser = vim.treesitter.get_parser(buffer, "java", {})
  local tree = parser:parse()[1]
  return tree:root()
end

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
  local query = ts_query("(formal_parameters (formal_parameter (identifier) @param_name))")
  local params = {}

  for _, node in query:iter_captures(params_node, buffer, 0, -1) do
    local param_name = vim.treesitter.get_node_text(node, buffer)
    table.insert(params, param_name)
  end

  return params
end

local function parse_method(method_node, buffer)

  local query = ts_query([[(method_declaration
    (modifiers) @method_modifiers
    (identifier) @method_name
    (formal_parameters) @method_parameters
  )]])

  local method = {
    buffer = buffer,
    row = nil,
    col = nil,
    name = "?",
    privacy = " ",
    parameters = {}
  }

  for id, node in query:iter_captures(method_node, buffer, 0, -1) do
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
  local methods = {}

  local query = ts_query("(method_declaration) @method")
  for _, node in query:iter_captures(root(buffer), buffer, 0, -1) do
    table.insert(methods, parse_method(node, buffer));
  end

  return methods
end

return M
