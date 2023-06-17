local project = require("project_nvim")
local tree = require("nvim-tree")
local telescope = require("telescope")

project.setup()

tree.setup({
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
})

-- add projects support to telescope
telescope.load_extension("projects")
