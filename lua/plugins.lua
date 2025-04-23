-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Nerdtree
  use 'preservim/nerdtree'

  -- Navigation with TMUX
  use 'christoomey/vim-tmux-navigator'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-ui-select.nvim' }

  -- Theme
  use 'rebelot/kanagawa.nvim'
  use 'jacoborus/tender.vim'
  use 'savq/melange-nvim'
  use 'rmehri01/onenord.nvim'
  use 'AlexvZyl/nordic.nvim'
  use 'marko-cerovac/material.nvim'
  use 'Mofiqul/vscode.nvim'
  use 'tyrannicaltoucan/vim-deep-space'

  -- TreeSitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/playground'

  -- LSP
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'mfussenegger/nvim-jdtls'
  use 'neovim/nvim-lspconfig'

  -- DAP
  use 'mfussenegger/nvim-dap'

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- Code actions pop-up
  use {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  }

  -- Tests
  use 'vim-test/vim-test'

  -- Git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use 'sindrets/diffview.nvim'

  -- Dev-ecosystem
  use 'ArturitoGit/dev-ecosystem.nvim'

  -- Table mode
  use 'dhruvasagar/vim-table-mode'

  -- Vim wiki
  use 'vimwiki/vimwiki'

end)
