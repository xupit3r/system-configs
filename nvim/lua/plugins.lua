vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- some themes
  use 'folke/tokyonight.nvim'
  use {
    'catppuccin/nvim',
    as = 'catppuccin'
  }

  -- lisp parens help
  use {
    'eraserhd/parinfer-rust',
    opt = true,
    rtp = 'target/release',
    run = 'cargo build --release'
  }

  -- yuck (EWW) support
  use 'elkowar/yuck.vim'

  -- rasi (rofi) support
  use {
    'Fymyte/rasi.vim',
    ft = 'rasi',
  }

  -- QML syntax highlighting
  use 'peterhoeg/vim-qml'

  -- scss support
  use 'cakebaker/scss-syntax.vim'

  -- show hex colors in editor
  use 'NvChad/nvim-colorizer.lua'

  -- LSP Client
  use 'neovim/nvim-lspconfig'

  -- BONUS: Customizations over LSP
  -- Show VSCode-esque pictograms
  use 'onsails/lspkind-nvim'

  -- Autocompletion plugin
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help'
    }
  }

  -- snippets
  use {
    'hrsh7th/cmp-vsnip',
    requires = {
      'hrsh7th/vim-vsnip',
      'rafamadriz/friendly-snippets',
    }
  }

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

  -- rainbow brackets!
  use {
    'HiPhish/nvim-ts-rainbow2',
    requires = {
      'nvim-treesitter/nvim-treesitter'
    },
  }

  -- autopairs!
  use {
    'windwp/nvim-autopairs',
    config = function() require("nvim-autopairs").setup {} end
  }

  -- highligh other instances of things
  use 'RRethy/vim-illuminate'

  -- multiple cursors!
  use 'mg979/vim-visual-multi'

  -- lsp servers, debuggers, and linters manager
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  -- rust tools (to use rust analyzer)
  use {
    'simrat39/rust-tools.nvim',
    requires = {
      'neovim/nvim-lspconfig'
    }
  }

  -- some nice treesitter tools
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    requires = {
      {"nvim-tree/nvim-web-devicons"},
      {"nvim-treesitter/nvim-treesitter"}
    }
  })

  -- lsp formatting and MOAR
  use 'jay-babu/mason-null-ls.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'

  -- telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  -- comment assist plugin
  use 'numToStr/Comment.nvim'

  -- indentation assitance
  use 'lukas-reineke/indent-blankline.nvim'

  -- project management
  use 'ahmedkhalf/project.nvim'

  -- file browser
  use {
    'nvim-telescope/telescope-file-browser.nvim',
    requires = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim'
    }
  }
 end)
