require('lspconfig').lua_ls.setup {
  capablities = require('cmp_nvim_lsp').default_capabilities(),
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          'vim',                -- Vim configuration
          'describe', 'it',     -- Busted test
        }
      }
    }
  }
}
