--
-- Telescope
--

local telescope = require("telescope")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>p", builtin.find_files, {})
vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
vim.keymap.set("n", "<leader>f", builtin.current_buffer_fuzzy_find, {})
vim.keymap.set("v", "<leader>gs", builtin.grep_string, {})
vim.keymap.set("n", "<leader>b", builtin.buffers, {})

-- initialize telescope
telescope.setup()
