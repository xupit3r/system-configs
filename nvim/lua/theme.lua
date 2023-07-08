-- setup the tokyonight theme
require("tokyonight").setup({
	style = "storm",
	terminal_colors = true,
	styles = {
		comments = { italic = true },
		keywords = { bold = true },
		functions = { italic = true },
		sidebars = "dark",
		floats = "dark",
	},
	sidebars = { "qf", "help", "packer" },
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
			base = "#222222",
			mantle = "#222222",
			crust = "#222222",
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

require("rose-pine").setup({
	--- @usage 'auto'|'main'|'moon'|'dawn'
	variant = "auto",
	--- @usage 'main'|'moon'|'dawn'
	dark_variant = "main",
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = false,
	disable_float_background = false,
	disable_italics = false,

	--- @usage string hex value or named color from rosepinetheme.com/palette
	groups = {
		background = "base",
		background_nc = "_experimental_nc",
		panel = "surface",
		panel_nc = "base",
		border = "highlight_med",
		comment = "muted",
		link = "iris",
		punctuation = "subtle",

		error = "love",
		hint = "iris",
		info = "foam",
		warn = "gold",

		headings = {
			h1 = "iris",
			h2 = "foam",
			h3 = "rose",
			h4 = "gold",
			h5 = "pine",
			h6 = "foam",
		},
		-- or set all headings at once
		-- headings = 'subtle'
	},

	-- Change specific vim highlight groups
	-- https://github.com/rose-pine/neovim/wiki/Recipes
	highlight_groups = {
		ColorColumn = { bg = "rose" },

		-- Blend colours against the "base" background
		CursorLine = { bg = "foam", blend = 10 },
		StatusLine = { fg = "love", bg = "love", blend = 10 },
	},
})

-- onedark theme
require("onedark").setup({
	style = "darker",
})

vim.cmd("colorscheme onedark")
