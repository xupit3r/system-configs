--
-- Telescope
--

local telescope = require('telescope')
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('v', '<leader>gs', builtin.grep_string, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})

telescope.setup()

