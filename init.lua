-- Source vimrc
vim.cmd('source ~/.vimrc')
vim.cmd('set exrc')

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

-- Default indenting
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.softtabstop=0
vim.o.expandtab=false

-- Scroll horizontally
vim.keymap.set('n', '<Left>', '20zh')
vim.keymap.set('n', '<Right>', '20zl')

-- Grep configuration
vim.o.grepprg = 'grep -IHrn --exclude-dir={\\.git,target,node_modules,dist,dump,.idea}'
vim.o.grepformat = '%f:%l:%m'
vim.keymap.set('n', '<Leader>g', [["kyiw:<C-u>grep '<C-r>k']]) -- Feed grep with word under cursor
vim.keymap.set('v', '<Leader>g', [["ky:<C-u>grep '<C-r>k']]) -- Feed grep with visual selection

-- Terminal to normal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
-- Make :term run in Terminal Mode
vim.cmd([[autocmd TermOpen * startinsert]])

vim.o.compatible = false
vim.cmd('syntax enable')
vim.cmd('filetype plugin on')
vim.cmd('packadd cfilter')

-- Enable :find
vim.o.path = vim.o.path..'**'
vim.o.wildmenu = true
vim.o.wildignore = '**/target/**,**/dist/**,**/node_modules/**,**/.git/**,**/public/**,**/*.class,**/*.o,**/*.hi'

-- Keep cursor position after visual mode yank
vim.keymap.set('v', 'y', 'ygv<Esc>')

-- Let 2 line spaces on zt
vim.keymap.set('n', 'zt', 'zt2<C-y>')
vim.keymap.set('n', 'zb', 'zb2<C-e>')

-- Yank * and +
vim.keymap.set('v', '<Leader>y', '"+ygv"*y')
vim.keymap.set('n', '<Leader>y', ':<C-u>%y +<CR>:<C-u>%y *<CR>', { silent=true })

-- Macros
vim.keymap.set('n', 'Q', 'Qj')
vim.keymap.set('v', 'Q', ":<C-U>'<,'>norm! Q<CR>")

-- Easily hide search results
vim.keymap.set('n', '<Leader>l', ':noh<CR>')

-- Like * but do not jump
-- vim.keymap.set('n', 'ù', '"kyiw/<C-R>k')
-- vim.keymap.set('v', 'ù', '"ky/<C-R>k')

-- Save & Run configuration
vim.keymap.set('n', '<Leader><CR>', ':<C-u>wall | make<CR>')

-- Go to previous/next element in quickfix list
vim.keymap.set('n', '²', ':cp<CR>')
vim.keymap.set('n', 'é', ':cn<CR>')

-- Toggle quickfix list
vim.keymap.set('n', '<Leader>q', require('quickfix.toggle'))

-- Custom vim scritps
vim.cmd('runtime ./vim/filetypes.vim')
vim.cmd('runtime ./vim/abbreviations.vim')
vim.cmd('runtime ./vim/tabline/tabline.vim')
vim.cmd('runtime ./vim/autobracket/autobracket.vim')
vim.cmd('runtime ./vim/quickfix-shrink-paths.vim')
vim.cmd('runtime ./vim/camel-case.vim')
vim.cmd('runtime ./vim/better-git.vim')

-- Plugins
require('plugins')

-- Own
require('helpers/selection')
require('awk')
require('select')
require('java.methods.locate')
require('java.methods.select')
require('quickfix.remove')

-- Theme
require('theme')

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
