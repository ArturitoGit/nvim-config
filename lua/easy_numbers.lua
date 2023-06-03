-- In normal mode, make numbers accessible without pressing SHIFT

local scope = 'n'

local function invert(k1, k2)
  vim.keymap.set(scope, k1, k2)
  vim.keymap.set(scope, k2, k1)
end

local function invertAll(keys)
  for _, pair in pairs(keys) do
    invert(pair[1], pair[2])
  end
end

invertAll {
  { '1', '&' },
  { '2', 'é' },
  { '3', '"' },
  { '4', '\''},
  { '5', '(' },
  { '6', '-' },
  { '7', 'è' },
  { '8', '_' },
  { '9', 'ç' },
  { '0', 'à' }
}
