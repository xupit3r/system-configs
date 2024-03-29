local servers = {
	"cssls",
	"clojure_lsp",
	"emmet_ls",
	"jsonls",
	"lua_ls",
	"marksman",
	"rust_analyzer",
	"sqlls",
	"tsserver",
	"volar",
}

-- Mason Setup
-- need to figure out how to run :MasonInstall here...
-- codelldb needs some auto install'n
require("mason").setup({
	ui = {
		icons = {
			package_installed = "",
			package_pending = "",
			package_uninstalled = "",
		},
	},
})

-- set of language servers i would like to have
-- installed
require("mason-lspconfig").setup({
	ensure_installed = servers,
	auto_install = true,
})

-- Completion Plugin Setup
local cmp = require("cmp")

-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }

-- some additional compltion stuffs...
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300)

local kind_icons = {
	Text = "",
	Method = "󰘧",
	Function = "󰘧",
	Constructor = "󱌢",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},
	-- Installed sources:
	sources = cmp.config.sources({
		{
			name = "nvim_lsp",
			entry_filter = function(entry, ctx)
				-- filter out any possible snippets
				if entry:get_kind() == 15 then
					return false
				end
				return true
			end,
		},
		{ name = "conjure" },
		{
			name = "vsnip",
			entry_filter = function(entry, ctx)
				-- don't show these little shits
				return false
			end,
		},
		{ name = "nvim_lua" },
	}),
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = kind_icons[vim_item.kind]
			vim_item.menu = ({
				nvim_lsp = "",
				conjure = "",
				nvim_lua = "",
				vsnip = "",
			})[entry.source.name]
			return vim_item
		end,
	},
})

-- Use buffer source for `/`
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- work better with autopairs
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- attach
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gk", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "gn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "g.", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

		vim.keymap.set("n", "gf", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- disable this, cause the snippets get reeeaaallll annoying and
-- are only marginally useful IMO...
capabilities.textDocument.completion.completionItem.snippetSupport = false

-- Activate LSPs
local lspconfig = require("lspconfig")

lspconfig.cssls.setup({
	capabilities = capabilities,
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
})

lspconfig.marksman.setup({
	capabilities = capabilities,
})

lspconfig.tsserver.setup({
	capabilities = capabilities,
})

lspconfig.sqlls.setup({
	capabilities = capabilities,
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					"vim",
					"require",
					"use",
				},
			},
		},
		workspace = {
			library = vim.api.nvim_get_runtime_file("", true),
		},
		telementry = {
			enable = false,
		},
	},
})

lspconfig.volar.setup({
	capabilities = capabilities,
	filetypes = {
		"javascript",
		"javascriptreact",
		"vue",
		"json",
	},
})

lspconfig.emmet_ls.setup({
	capabilities = capabilities,
	filetypes = {
		"css",
		"html",
		"less",
		"sass",
		"scss",
		"pug",
	},
})

lspconfig.clojure_lsp.setup({
	cmd = { "/usr/bin/clojure-lsp" },
	capabilities = capabilities,
})
-- setup rust tools
local rt = require("rust-tools")

rt.setup({
	server = {
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
		end,
	},
})

-- LSP Diagnostics Options Setup
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

sign({ name = "DiagnosticSignError", text = "" })
sign({ name = "DiagnosticSignWarn", text = "" })
sign({ name = "DiagnosticSignHint", text = "" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	update_in_insert = true,
	underline = true,
	severity_sort = false,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
  set signcolumn=yes
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
