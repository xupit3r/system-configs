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
	lualine_bold = "bold",
})

-- setup/alter catppuccin theme
require("catppuccin").setup({
	flavour = "frappe",
	color_overrides = {
		frappe = {
			base = "#111111",
			mantle = "#111111",
			crust = "#111111",
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
			Comment = { fg = colors.flamingo },
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

-- some vivid synthwave-y type of colors
-- currently have a definition for onedark
-- maybe add others?
local synthy = {
	ondark = {
		black = "#051521",
		bg0 = "#01182e",
		bg1 = "#0b2f4a",
		bg2 = "#0e3c5e",
		bg3 = "#114973",
		bg_d = "#04111d",
		bg_blue = "#09618d",
		bg_yellow = "#fed989",
		fg = "#fff5fe",
		purple = "#c75ae8",
		green = "#3be528",
		orange = "#ff901f",
		blue = "#41a7fc",
		yellow = "#f8f030",
		cyan = "#03fff0",
		red = "#ff2975",
		grey = "#686868",
		light_grey = "#b3b3b3",
		dark_cyan = "#008179",
		dark_red = "#940035",
		dark_yellow = "#8f8a05",
		dark_purple = "#71148d",
		diff_add = "#5b7a42",
		diff_delete = "#794247",
		diff_change = "#256596",
		diff_text = "#2f7cb8",
	},
}

-- onedark theme
require("onedark").setup({
	style = "deep",
	code_style = {
		comments = "italic",
		keywords = "bold",
		functions = "bold,italic",
		strings = "italic",
		variables = "none",
	},
	colors = synthy.ondark,
})

vim.cmd("colorscheme onedark")
