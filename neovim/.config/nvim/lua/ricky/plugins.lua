local status, packer = pcall(require, 'packer')
if (not status) then
  print('Packer is not installed')
  return
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Plugin manager
  use 'nvim-lua/plenary.nvim' -- Common utilities

  use 'folke/tokyonight.nvim' -- Color theme

  use 'kyazdani42/nvim-web-devicons' -- Icons for file explorer and status line
  use 'nvim-lualine/lualine.nvim' -- Status line

  use 'nvim-telescope/telescope.nvim' -- Fuzzy finder
  use 'ThePrimeagen/harpoon' -- File switching
  use("mbbill/undotree") -- Undo history visualizer

  use 'norcalli/nvim-colorizer.lua' -- Color preview in color codes
  use 'windwp/nvim-autopairs' -- Autopairs for nvim-cmp
  use 'windwp/nvim-ts-autotag' -- Autotag for treesitter

  use 'tpope/vim-fugitive' -- Git commands
  use 'lewis6991/gitsigns.nvim' -- Git signs

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  } -- Syntax highlighting and code navigation

  -- LSP Zero
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
  
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lua'},
  
      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }
end)
