local comment = require("Comment")
local npairs = require("nvim-autopairs")
local trouble = require("trouble")
local todos = require("todo-comments")

-- comment toggl'n
comment.setup()

-- trouble project informational explorer
trouble.setup()

-- stuff to work with todo comments n'at
todos.setup()

-- setup autopairs to use treesitter
npairs.setup({
	check_ts = true,
	fast_wrap = {},
})
