require('nvim-treesitter').install {
  'lua',
  'rust',
  'javascript', 'typescript',
  'tsx'
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'lua',
    'rs',
    'js', 'ts',
    'tsx'
  },
  callback = function() vim.treesitter.start() end,
})
