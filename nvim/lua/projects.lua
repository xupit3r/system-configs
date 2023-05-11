require("project_nvim").setup({
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
})

-- add projects support to telescope
local telescope = require("telescope")
telescope.load_extension("projects")
