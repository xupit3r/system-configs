require("plugins")
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

-- setup packer to run on --[[ changes ]]
vim.cmd([[
augroup Packer
  autocmd!
  autocmd BufWritePost init.lua PackerCompile
augroup end
]])

-- Highlight on yank
vim.cmd([[
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]])

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
  set signcolumn=yes
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- autowrite content
vim.o.autowriteall = true

-- Show the line numbers
vim.wo.number = true

-- Show chars at the end of line
vim.o.list = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250

-- Shows signs by Autocompletion plugin
vim.wo.signcolumn = "yes"

-- Enable termguicolors. Very essential if you want 24-bit RGB color in TUI.
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect,noinsert"

-- some indentation rules
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Enable break indent
vim.o.breakindent = true

-- disable warnings about perl
vim.g.loaded_perl_provider = 0
