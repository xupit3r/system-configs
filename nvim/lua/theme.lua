-- setup the tokyonight theme
require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "storm",
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    sidebars = "dark",
    floats = "dark",
  },
  sidebars = { "qf", "help", "packer" },
})


-- setup/alter catpuccin theme
require('catppuccin').setup {
  flavour = 'mocha',
  color_overrides = {
    mocha = {
      base = "#000000",
      mantle = "#000000",
      crust = "#000000",
    },
  },
  highlight_overrides = {
    mocha = function(C)
      return {
        TabLineSel = { bg = C.pink },
        CmpBorder = { fg = C.surface2 },
        Pmenu = { bg = C.none },
        TelescopeBorder = { link = "FloatBorder" },
      }
    end,
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true
  }
}

vim.cmd [[ colorscheme catppuccin ]]
