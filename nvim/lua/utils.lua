-- comment toggl'n
require("Comment").setup()

-- show indent guides
require("indent_blankline").setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})

-- some config for the auotpairs stuffs...
local npairs = require("nvim-autopairs")
npairs.setup({
	check_ts = true,
})
