local function remap_local(mode, key, action, options)
  if options == nil then options = {} end
  options.buffer = 0
  vim.keymap.set(mode, key, action, options)
end

-- LSP related mappings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(infos)
    local filetype = vim.bo[infos.buf].filetype

    -- Remap LSP functionnalities
    remap_local('n', '<Leader>r', vim.lsp.buf.rename)
    remap_local('n', '<C-n>', vim.lsp.buf.code_action)
    remap_local('n', 'gd', vim.lsp.buf.definition)
    remap_local('n', 'gr', vim.lsp.buf.references)
    remap_local('n', 'gi', require('telescope.builtin').lsp_implementations)
    remap_local('n', '<Leader>s', require('telescope.builtin').lsp_document_symbols)
    remap_local('n', '<Leader>d', vim.diagnostic.open_float)
    remap_local('i', '<C-,>', vim.lsp.buf.signature_help)

    if (filetype ~= "lua") then
      remap_local('n', 'K', vim.lsp.buf.hover)
    end
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
