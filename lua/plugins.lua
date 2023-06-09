-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

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
  
  -- TreeSitter
  use 'nvim-treesitter/nvim-treesitter'

  -- LSP
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'mfussenegger/nvim-jdtls'
  use 'neovim/nvim-lspconfig'

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
  use 'scrooloose/nerdtree'
  -- Game
  use 'ThePrimeagen/vim-be-good'

  -- Tests
  use 'vim-test/vim-test'

  -- Markdown
  use({'jakewvincent/mkdnflow.nvim',
    config = function()
        require('mkdnflow').setup()
    end
  })

  -- Surround
  use({
      "kylechui/nvim-surround",
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  })

  -- Null-LS
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Git
  use 'tpope/vim-fugitive'
end)
