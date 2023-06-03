vim.cmd([[set shiftwidth=2 smarttab]])
vim.cmd([[set expandtab]])
vim.cmd([[set tabstop=8 softtabstop=0]])

require('lspconfig').lua_ls.setup{
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}
