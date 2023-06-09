require('plugins')

-- Helpers
require('helpers/selection')

-- Mason
require("mason").setup()
require("mason-lspconfig").setup()
require('lsp_config')

-- NerdTree
vim.cmd([[let g:NERDTreeHijackNetrw=0]]) -- Disable opening with NerdTree
vim.cmd([[nnoremap <silent> <C-t> :NERDTreeToggle<CR>]])
vim.keymap.set('n', '<A-t>', ':NERDTreeFind<CR>')

-- Telescope
require('telescope_config')

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

-- Global configurations
vim.cmd([[set splitright]])
vim.cmd([[set number]])
vim.cmd([[set relativenumber]])

require('easy_numbers')

-- Test autocommands
vim.api.nvim_create_autocmd(
  "BufAdd",
  {
    command = [[echo "Test java file"]],
    pattern = "*.java"
  }
)

function fill()
  local nbOfLines = #vim.api.nvim_buf_get_lines(0, 0, -1, false)
  if nbOfLines > 0 then return end
  vim.api.nvim_buf_set_lines(0,0, false, { "public class Test {", "}" })
end
