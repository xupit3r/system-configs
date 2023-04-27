require('plugins')

vim.cmd [[
augroup Packer
  autocmd!
  autocmd BufWritePost init.lua PackerCompile
augroup end
]]

-- autowrite content
vim.o.autowriteall = true

-- Show the line numbers
vim.wo.number = true

-- Show chars at the end of line
vim.opt.list = true

-- Enable break indent
vim.o.breakindent = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250

-- Shows signs by Autocompletion plugin
vim.wo.signcolumn = 'yes'

-- Enable termguicolors. Very essential if you want 24-bit RGB color in TUI.
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone'

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.cmd [[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]]

-- Plugin configuration
-- LSP and LS Installer
require('lspconfig')
local lsp_installer = require("nvim-lsp-installer")

-- The required servers
local servers = {
  "awkls",
  "bashls",
  "clangd",
  "cmake",
  "cssls",
  "clojure_lsp",
  "dockerls",
  "dotls",
  "html",
  "jsonls",
  "pyright",
  "quick_lint_js",
  "tsserver",
  "marksman",
  "intelephense",
  "volar"
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

local on_attach = function(_, bufnr)
  -- Create some shortcut functions.
  -- NOTE: The `vim` variable is supplied by Neovim.
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = {noremap=true, silent=true}

  -- ======================= The Keymaps =========================
  -- jump to definition
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

  -- Format buffer
  buf_set_keymap('n', '<F3>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- Jump LSP diagnostics
  -- NOTE: Currently, there is a bug in lspsaga.diagnostic module. Thus we use
  --       Vim commands to move through diagnostics.
  buf_set_keymap('n', '[g', ':Lspsaga diagnostic_jump_prev<CR>', opts)
  buf_set_keymap('n', ']g', ':Lspsaga diagnostic_jump_next<CR>', opts)

  -- Rename symbol
  buf_set_keymap('n', '<leader>rn', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)

  -- Find references
  buf_set_keymap('n', 'gr', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', opts)

  -- Doc popup scrolling
  buf_set_keymap('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
  buf_set_keymap('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
  buf_set_keymap('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)

  -- codeaction
  buf_set_keymap('n', '<leader>ac', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
  buf_set_keymap('v', '<leader>a', ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)

  -- Floating terminal
  -- NOTE: Use `vim.cmd` since `buf_set_keymap` is not working with `tnoremap...`
  vim.cmd [[
  nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
  tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>
  ]]
end

local server_specific_opts = {
  sumneko_lua = function(opts)
    opts.settings = {
      Lua = {
        -- NOTE: This is required for expansion of lua function signatures!
        completion = {callSnippet = "Replace"},
        diagnostics = {
          globals = {'vim'},
        },
      },
    }
  end,

  html = function(opts)
    opts.filetypes = {"html", "htmldjango"}
  end,
}

-- `nvim-cmp` comes with additional capabilities, alongside the ones
-- provided by Neovim!
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

lsp_installer.on_server_ready(function(server)
  -- the keymaps, flags and capabilities that will be sent to the server as
  -- options.
  local opts = {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = capabilities,
  }

  -- If the current surver's name matches with the ones specified in the
  -- `server_specific_opts`, set the options.
  if server_specific_opts[server.name] then
    server_specific_opts[server.name](opts)
  end

  -- And set up the server with our configuration!
  server:setup(opts)
end)

-- nvim-cmp
local lspkind = require('lspkind')
local cmp = require("cmp")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp_kinds = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "塞",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },

  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    -- Use Tab and Shift-Tab to browse through the suggestions.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
  },
})

-- Use buffer source for `/`
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- autopairs
vim.g.AutoPairs = {
  ['(']=')',
  ['[']=']',
  ['{']='}',
  ["'"]="'",
  ['"']='"',
  ['`']='`',
  ['<']='>',
}

-- onedark
require("onedark").setup({
  style = "darker",
})
require('onedark').load()

-- lualine
require('lualine').setup({
  sections = {
    lualine_c = {
      {'filename', path = 1},
      'lsp_progress',
    },
  },
})

-- treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {"python", "rust", "c", "cpp", "bash", "go", "html"},
  highlight = {
    enable = true, -- false will disable the whole extension
  },
}

-- lspsaga
require("lspsaga").init_lsp_saga({
  finder_action_keys = {
    open = '<CR>',
    quit = {'q', '<esc>'},
  },
  code_action_keys = {
    quit = {'q', '<esc>'},
  },
  rename_action_keys = {
    quit = '<esc>',
  },
})


