-- LUA
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

-- SQL
require('lspconfig').sqlls.setup {
  root_dir = function() return vim.env.HOME.."/.config/sql-language-server/" end,
  connections = {
    {
      name= "local",
      adapter= "mysql",
      host= "localhost",
      port= 3306,
      user= "root",
      password= "root",
      database= "test",
      projectPaths= { "/tmp" },
    }
  }
}
