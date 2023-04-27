vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- some themes
  use 'folke/tokyonight.nvim'
  use 'navarasu/onedark.nvim'
  use 'nyoom-engineering/oxocarbon.nvim'
  use "lunarvim/synthwave84.nvim"
 
  -- lisp parens help
  use {
    'eraserhd/parinfer-rust',
    opt = true,
    rtp = 'target/release',
    run = 'cargo build --release'
  }

  -- yuck (EWW) support
  use 'elkowar/yuck.vim'
  
  -- scss support
  use 'cakebaker/scss-syntax.vim'

  -- clojure IDE
  use 'Olical/conjure'

  -- LSP Client
  use 'neovim/nvim-lspconfig'

  -- Language Server installer
  use {
    'williamboman/nvim-lsp-installer',
    requires = 'neovim/nvim-lspconfig',
  }

  -- BONUS: Customizations over LSP
  -- Show VSCode-esque pictograms
  use 'onsails/lspkind-nvim'

  -- show various elements of LSP as UI
  use {'tami5/lspsaga.nvim', requires = {'neovim/nvim-lspconfig'}}

  -- Autocompletion plugin
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    }
  }

  -- snippets
  use {
    'hrsh7th/cmp-vsnip', requires = {
      'hrsh7th/vim-vsnip',
      'rafamadriz/friendly-snippets',
    }
  }

  -- bracket autocompletion
  use 'vim-scripts/auto-pairs-gentle'

  -- Fancier statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      'arkav/lualine-lsp-progress',
    },
  }

  -- Fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
end)
