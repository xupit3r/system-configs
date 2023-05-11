-- comment toggl'n
require("Comment").setup()

-- some config for the auotpairs stuffs...
local npairs = require("nvim-autopairs")
npairs.setup({
	check_ts = true,
})
