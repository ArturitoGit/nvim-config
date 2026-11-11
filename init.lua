vim.cmd('source ~/.vimrc')
vim.cmd('source ~/.config/vim/vai.vim')

require('plugins')
require('oil-config')
require('treesitter-config')
require('lsp')
require('theme-config')

-- Indent configuration
vim.cmd('set shiftwidth=2 softtabstop=2 expandtab')

-- Completion
require('blink.cmp').setup {
  cmdline = { enabled = false },
  signature = { enabled = true },
  keymap = { preset = 'super-tab' },
  sources = {
    default = { 'lsp', 'snippets' }
  },
  completion = {
    accept = { auto_brackets = { enabled = false } },
    menu = {
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind" }
        }
      }
    },
    documentation = {
      auto_show = true
    }
  }
}
