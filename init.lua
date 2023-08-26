-- Leader key
vim.keymap.set('n', '<space>', '<nop>')
vim.g.mapleader = " "

-- Global configurations
vim.o.number = true
vim.o.relativenumber = true
vim.o.splitright = true
vim.o.wrap = false
vim.o.cursorline = true

-- Make :term run in Terminal Mode
vim.cmd([[autocmd TermOpen * startinsert]])

vim.o.compatible = false
vim.cmd('syntax enable')
vim.cmd('filetype plugin on')

-- Enable :find
vim.o.path = vim.o.path..'**'
vim.o.wildmenu = true
vim.o.wildignore = '**/dist/**,**/node_modules/**'

-- Keep visual selection after indenting
vim.keymap.set('v', '<lt>', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Open Git status in a new tab
vim.api.nvim_create_user_command('GG', 'tab Git', {})

-- Center after jump
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'p', 'pzz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Custom tabline
vim.cmd('source ./vim/tabline/tabline.vim')

-- Plugins
require('plugins')

-- Own
require('helpers/selection')
require('easy_numbers')
require('awk')

---- Theme
vim.cmd([[colorscheme onenord]])

-- Side bar
-- require('nerdtree_config')

-- Telescope
require('telescope_config')

-- TreeSitter
require('treesitter')

-- LSP
require("mason").setup()
require("mason-lspconfig").setup()
require('lsp_config')

-- Auto-completion
require('completion')

-- Null-ls
-- require('null_ls_config')

-- Tests
require('tests')
