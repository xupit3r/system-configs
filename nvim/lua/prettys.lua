-- lualine
require("lualine").setup({
	options = {
		theme = "auto",
	},
	sections = {
		lualine_c = {
			{ "filename", path = 1 },
			"lsp_progress",
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
