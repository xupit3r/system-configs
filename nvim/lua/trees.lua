-- treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	sync_install = true,
	auto_install = true,
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
})
