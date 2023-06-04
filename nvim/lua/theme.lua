-- setup the tokyonight theme
require("tokyonight").setup({
	style = "night",
	terminal_colors = true,
	styles = {
		comments = { italic = true },
		keywords = { bold = true },
		functions = { italic = true },
		sidebars = "dark",
		floats = "dark",
	},
	sidebars = { "qf", "help", "packer" },
	on_colors = function(colors)
		colors.bg_dark = "#000000"
		colors.bg = "#000000"
	end,
	on_highlights = function(hl, c)
		hl.DiagnosticUnnecessary = {
			fg = "#187687",
		}
		hl.TelescopeNormal = {
			bg = c.bg_dark,
		}
		hl.TelescopePromptNormal = {
			bg = c.bg_dark,
		}
		hl.TelescopePromptBorder = {
			bg = c.b_dark,
		}
		hl.TelescopePromptTitle = {
			bg = c.bg_dark,
		}
		hl.TelescopePreviewTitle = {
			bg = c.bg_dark,
		}
		hl.TelescopeResultsTitle = {
			bg = c.bg_dark,
		}
	end,
})

-- setup/alter catpuccin theme
require("catppuccin").setup({
	flavour = "mocha",
	color_overrides = {
		mocha = {
			base = "#000000",
			mantle = "#000000",
			crust = "#000000",
		},
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		functions = { "italic" },
		keywords = { "bold" },
	},
	custom_highlights = function(colors)
		return {
			TabLineSel = {
				bg = colors.peach,
				fg = colors.surface2,
			},
		}
	end,
	integrations = {
		cmp = true,
		gitsigns = true,
		telescope = true,
	},
})

require("gruvbox").setup({
	undercurl = true,
	underline = true,
	bold = true,
	italic = {
		strings = true,
		comments = true,
		conditionals = true,
		operators = false,
		folds = true,
	},
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true,
	contrast = "hard",
	palette_overrides = {},
	overrides = {},
	dim_inactive = false,
	transparent_mode = false,
})

vim.cmd([[ colorscheme tokyonight ]])
