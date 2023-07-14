-- lualine
require("lualine").setup({
	options = {
		theme = "auto",
		component_separators = "|",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{ "mode", separator = { left = "" }, right_padding = 2 },
		},
		lualine_c = {
			{ "filename", path = 1 },
			"lsp_progress",
		},
		lualine_z = {
			{ "location", separator = { right = "" }, left_padding = 2 },
		},
	},
})

-- color highlighting
require("colorizer").setup({
	filetypes = {
		"css",
		"javascript",
	},
	user_default_options = {
		mode = "background",
		css = true,
		sass = {
			enable = true,
			parsers = { "css" },
		},
		virtualtext = "■",
		always_update = false,
	},
})

-- provide shortcut for colorizer toggle
vim.keymap.set("n", "<leader>c", ":ColorizerToggle<CR>", { silent = true })
