local hasConfig, foundConfig = pcall(require, 'config')

-- Default value for config
local config
if hasConfig then
  config = foundConfig
else
  config = {}
end

-- Config tree node object
local function wrap(name, node)
  return {

    mandatory = function(key)
      assert(node[key] ~= nil, key..' is required for '..name)
      return node[key]
    end,

    sub = function(key)
      local value = node[key]
      if value == nil then return nil end
      return wrap(key, value)
    end,

    has = function(key)
      return node[key] ~= nil
    end,

    get = function(key)
      return node[key]
    end,

    orElse = function(default)
      if node == nil then
        return default
      else
        return node
      end
    end
  }
end

return wrap("config", config)
