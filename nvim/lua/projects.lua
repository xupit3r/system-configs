local project = require("project_nvim")
local telescope = require("telescope")

-- projects n't
project.setup()

-- add projects support to telescope
telescope.load_extension("projects")
