--
-- Telescope
--

local telescope = require("telescope")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "tp", builtin.find_files, {})
vim.keymap.set("n", "tg", builtin.live_grep, {})
vim.keymap.set("n", "tf", builtin.current_buffer_fuzzy_find, {})
vim.keymap.set("v", "tgs", builtin.grep_string, {})
vim.keymap.set("n", "tb", builtin.buffers, {})

-- initialize telescope
telescope.setup()
