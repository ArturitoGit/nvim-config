local github = function(x) return 'https://github.com/' .. x end

vim.pack.add({

  -- File explorer
  github('stevearc/oil.nvim'),

  -- Treesitter
  github('nvim-treesitter/nvim-treesitter'),

  -- LSP Config
  github('neovim/nvim-lspconfig'),

  -- Blink for completion
  -- Build before first time : require('blink.cmp').build():pwait()
  github('saghen/blink.lib'),
  github('saghen/blink.cmp'),

  -- Autotag for HTML
  github('tronikelis/ts-autotag.nvim')
})
