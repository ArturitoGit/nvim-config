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

return separator
