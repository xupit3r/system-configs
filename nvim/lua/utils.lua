local comment = require("Comment")
local npairs = require("nvim-autopairs")
local trouble = require("trouble")
local todos = require("todo-comments")
--qlocal surround = require("nvim-surround")

-- comment toggl'n
comment.setup({
	ignore = "^$",
	toggler = {
		line = "<leader>cc",
		block = "<leader>bc",
	},
	opleader = {
		line = "<leader>c",
		block = "<leader>b",
	},
})

-- trouble project informational explorer
trouble.setup()

-- stuff to work with todo comments n'at
todos.setup()

-- setup autopairs to use treesitter
npairs.setup({
	check_ts = true,
	fast_wrap = {},
})

-- setup surround to surround stuff with other stuff..
--surround.setup()
