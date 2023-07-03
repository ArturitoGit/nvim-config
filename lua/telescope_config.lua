local actions = require('telescope.actions')

require("telescope").setup {
  defaults = {

    -- Layout
    layout_strategy = 'flex',
    layout_config = { height = 0.85, width = 0.85 },

    initial_mode = 'insert', -- OR : 'normal'
    file_ignore_patterns = {
	    "build/*",
	    "bin/*",
	    "gradle/*", ".m2/*",
            "*.jar"
    },
    path_display = {
      shorten = {
        len = 3, exclude = {1, -1}
      },
      truncate = true
    },
    dynamic_preview_title = true,
  },

  pickers = {
    colorscheme = {
      enable_preview = true
    },
    find_files = {
      no_ignore = true
    },
    live_grep = {
      layout_strategy = 'vertical',
      mappings = {
        i = {
          -- Ctrl-Q will open QuickFix view with result
          ["C-q"] = function(prompt_bfnr)
            actions.send_to_qflist(prompt_bfnr)
            actions.open_qflist(prompt_bfnr)
          end
        },
      },
    },
  },

  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  },
}
require("telescope").load_extension("ui-select")

-- Remap
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-n>', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.buffers, {})
vim.keymap.set('n', '<C-h>', builtin.highlights, {})
vim.keymap.set('n', '<C-h>', builtin.lsp_document_symbols, {})
vim.keymap.set('n', 'gr', builtin.lsp_references, {})
vim.keymap.set('n', 'gs', builtin.lsp_workspace_symbols, {})

vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
-- Live grep with selected as default text
vim.keymap.set('v', '<C-f>', "y:Telescope live_grep default_text=<C-r>0<CR>")
