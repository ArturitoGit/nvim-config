local function separator()
  local mappings = {
    ['csv_semicolon'] = ';',
    ['tsv'] = '\t'
  }

  return mappings[vim.o.filetype] or ';'
end

return separator
