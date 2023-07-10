-- disable netrw (pssst, it is being replaced)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- load my various configuration files
require("plugins")
require("providers")
require("lsp")
require("saga")
require("trees")
require("gaze")
require("format")
require("utils")
require("prettys")
require("theme")
require("projects")
require("vcs")
