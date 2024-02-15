-- LSP related mappings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function()
    -- Remap LSP functionnalities
    vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename)
    vim.keymap.set('n', '<C-n>', vim.lsp.buf.code_action)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references)
    vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations)
    vim.keymap.set('n', '<Leader>s', require('telescope.builtin').lsp_document_symbols)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover)
    vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float)
    vim.keymap.set('i', '<C-,>', vim.lsp.buf.signature_help)
  end
})

-- Build capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local util = require('lspconfig').util

require('lspconfig').hls.setup {
  capabilities = capabilities,
  filetypes = { "haskell", 'lhaskell', 'cabal' },
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  root_dir = function (filepath)
    return (
      util.root_pattern('hie.yaml', 'stack.yaml', 'cabal.project')(filepath)
      or util.root_pattern('*.cabal', 'package.yaml')(filepath)
    )
  end,
  settings = {
    haskell = {
      cabalFormattingProvider = "cabalfmt",
      formattingProvider = "ormolu"
    }
  },
  single_file_support = true
}

require('lspconfig').eslint.setup {
  filetypes = { 'javascript' },
  capabilities = capabilities,
  root_dir = function() return vim.fn.getcwd() end,
}

require('lspconfig').tsserver.setup {
  capabilities = capabilities,
  root_dir = function() return vim.fn.getcwd() end,
}

require('lspconfig').cssls.setup {
  capabilities = capabilities
}

-- LUA
require('lspconfig').lua_ls.setup {
  capabilities = capabilities,
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
  capabilities = capabilities,
}

-- Python
require('lspconfig').pylsp.setup {
  root_dir = function() return vim.fn.getcwd() end,
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}
