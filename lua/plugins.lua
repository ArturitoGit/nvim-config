-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Navigation with TMUX
  use 'christoomey/vim-tmux-navigator'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
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

  -- LSP
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'mfussenegger/nvim-jdtls'
  use 'neovim/nvim-lspconfig'
  use 'dnlhc/glance.nvim'

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

  -- NerdTree
  -- use 'scrooloose/nerdtree'

  -- Tests
  use 'vim-test/vim-test'

  -- Null-LS
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use 'sindrets/diffview.nvim'

end)
