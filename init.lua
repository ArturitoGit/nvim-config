-- Leader key
vim.keymap.set('n', '<space>', '<nop>')
vim.g.mapleader = " "

-- Global configurations
vim.o.number = true
vim.o.relativenumber = true
vim.o.splitright = true
vim.o.wrap = false
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.keywordprg = ''
vim.o.laststatus = 3

-- Scroll horizontally
vim.keymap.set('n', '<C-q>', '15zh')
vim.keymap.set('n', '<C-s>', '15zl')

-- Grep configuration
vim.o.grepprg = 'grep -Irn --exclude=*.{class,jar} --exclude-dir={.git,**/target/**,node_modules,dist}'
vim.keymap.set('n', '<Leader>g', [["kyiw:<C-u>grep '<C-r>k']]) -- Feed grep with word under cursor
vim.keymap.set('v', '<Leader>g', [["ky:<C-u>grep '<C-r>k']]) -- Feed grep with visual selection

-- Terminal to normal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
-- Make :term run in Terminal Mode
vim.cmd([[autocmd TermOpen * startinsert]])

-- Enable line number in netwr
vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

vim.o.compatible = false
vim.cmd('syntax enable')
vim.cmd('filetype plugin on')

-- Enable :find
vim.o.path = vim.o.path..'**'
vim.o.wildmenu = true
vim.o.wildignore = '**/dist/**,**/node_modules/**,**/.git/**,**/public/**,**/*.class'

-- Keep visual selection after indenting
vim.keymap.set('v', '<lt>', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Keep cursor position after visual mode yank
vim.keymap.set('v', 'y', 'ygv<Esc>')

-- Let 2 line spaces on zt
vim.keymap.set('n', 'zt', 'zt2<C-y>')
vim.keymap.set('n', 'zb', 'zb2<C-e>')

-- Yank * and +
vim.keymap.set('v', '<Leader>y', '"+ygv"*y')
vim.keymap.set('n', '<Leader>y', ':<C-u>%y +<CR>:<C-u>%y *<CR>', { silent=true })

-- Easily hide search results
vim.keymap.set('n', '<Leader>l', ':noh<CR>')

-- Like * but do not jump
vim.keymap.set('n', 'ù', '"kyiw/<C-R>k')
vim.keymap.set('v', 'ù', '"ky/<C-R>k')

-- Save & Run configuration
vim.keymap.set('n', '<Leader>r', ':<C-u>wall | make<CR>')

-- Custom vim scritps
vim.cmd('runtime ./vim/tabline/tabline.vim')
vim.cmd('runtime ./vim/autobracket/autobracket.vim')

-- Plugins
require('plugins')

-- Own
require('helpers/selection')
require('awk')
require('select')

-- Theme
require('theme')

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

-- Git
require('git_config')

-- Auto-completion
require('completion')

-- Null-ls
-- require('null_ls_config')

-- Tests
require('tests')
