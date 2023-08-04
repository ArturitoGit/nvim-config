-- Leader key
vim.keymap.set('n', '<space>', '<nop>')
vim.g.mapleader = " "

require('plugins')


-- Helpers
require('helpers/selection')

-- Mason
require("mason").setup()
require("mason-lspconfig").setup()
require('lsp_config')

require('nerdtree_config')

-- Telescope
require('telescope_config')

require('awk')

-- Theme
vim.cmd([[colorscheme onenord]])

-- TreeSitter
require('treesitter')

-- Auto-completion
require('completion')

-- Markdown
require('markdown_config')

-- Surround
require('nvim-surround').setup()

-- Null-ls
-- require('null_ls_config')

-- Tests
require('tests')

require('easy_numbers')

-- Make :term run in Terminal Mode
vim.cmd([[autocmd TermOpen * startinsert]])

-- Global configurations
vim.o.number = true
vim.o.relativenumber = true
vim.o.splitright = true

-- Easy navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
