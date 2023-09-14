-- LSP related mappings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function()
    -- Remap LSP functionnalities
    vim.keymap.set('n', '<A-r>', vim.lsp.buf.rename)
    vim.keymap.set('n', '<A-CR>', vim.lsp.buf.code_action)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations)
    vim.keymap.set('n', '<A-o>', require('telescope.builtin').lsp_document_symbols)
    vim.keymap.set('n', '<A-,>', vim.lsp.buf.hover)
  end
})

require('lspconfig').eslint.setup {
  filetypes = { 'javascript' },
  capablities = require('cmp_nvim_lsp').default_capabilities(),
  root_dir = function() return vim.fn.getcwd() end,
}

require('lspconfig').tsserver.setup {
  capablities = require('cmp_nvim_lsp').default_capabilities(),
  root_dir = function() return vim.fn.getcwd() end,
}

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

-- Kotlin
require('lspconfig').kotlin_language_server.setup {
  root_dir = function() return vim.fn.getcwd() end,
  settings = { kotlin = { compiler = { jvm = { target = "17" } } } },
  capablities = require('cmp_nvim_lsp').default_capabilities(),
}

-- Python
require('lspconfig').pylsp.setup {
  root_dir = function() return vim.fn.getcwd() end,
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}
