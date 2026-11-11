-- LSP related config
-- vim.lsp.log.set_level("INFO")

-- Server configurations
vim.lsp.config['extjs'] = {
  cmd = { '/home/arturito/Documents/prog/rust/rust_lsp/target/debug/tree-sitter-lab' },
  filetypes = { 'javascript' }
}

-- Enabled servers
vim.lsp.enable("extjs")
vim.lsp.enable("tsc")
vim.lsp.enable("oxlint")
vim.lsp.enable("oxfmt")

-- LSP related mappings & autocommands
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
vim.keymap.set("n", "<Space>d", function() vim.diagnostic.open_float() end)

vim.api.nvim_create_autocmd('BufWrite', {
  pattern = { '*.tsx', '*.ts' },
  callback = function()
    vim.lsp.buf.format()
  end
})
