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
vim.o.grepprg = 'grep -Irn --exclude=*.{class,jar} --exclude-dir={.git,**/target/**,node_modules,dist}'

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
vim.o.wildignore = '**/dist/**,**/node_modules/**,**/.git/**'

-- Keep visual selection after indenting
vim.keymap.set('v', '<lt>', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Keep cursor position after visual mode yank
vim.keymap.set('v', 'y', 'ygv<Esc>')

-- Open Git status in a new tab
vim.api.nvim_create_user_command('GG', 'tab Git', {})

-- Center after jump
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Let 2 line spaces on zt
vim.keymap.set('n', 'zt', 'zt2<C-y>')
vim.keymap.set('n', 'zb', 'zb2<C-e>')

-- Yank * and +
vim.keymap.set('v', '<Leader>y', '"+ygv"*y')
vim.keymap.set('n', '<Leader>y', ':<C-u>%y +<CR>:<C-u>%y *<CR>', { silent=true })

-- Custom vim scritps
vim.cmd('runtime ./vim/tabline/tabline.vim')
vim.cmd('runtime ./vim/autobracket/autobracket.vim')

-- Plugins
require('plugins')

-- Own
require('helpers/selection')
require('easy_numbers')
require('awk')

-- Theme
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
