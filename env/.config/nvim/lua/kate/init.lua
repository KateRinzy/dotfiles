---@diagnostic disable: undefined-global
vim.o.termguicolors = true

require("kate.remap")
require("kate.lazy_init")
require("kate.set-colors")
require("kate.set")
require("kate.configs.status-bar")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local kateGroup = augroup("kate", {})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function()
    if vim.bo.filetype == "" and vim.fn.expand("%:e") == "" then
      vim.bo.filetype = "text"
    end
  end,
})

autocmd('TextYankPost', {
  group = augroup('HighlightYank', {}),
  pattern = '*',
  callback = function()
    vim.hl.on_yank({
      higroup = 'IncSearch',
      timeout = 120,
    })
  end,
})

-- remove trailing whitespaces at the end of a line
autocmd({ "BufWritePre" }, {
  group = kateGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- https://swnakamura.github.io/posts/vim-japanese-input/
autocmd("InsertLeave", {
  group = kateGroup,
  pattern = "*",
  callback = function()
    vim.system({ "fcitx5-remote", "-c" })
  end,
})

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.pdf",
  callback = function()
    local file = vim.fn.expand("<afile>")
    vim.fn.jobstart({ "zathura", file }, { detach = true })
    vim.cmd("bdelete!")
  end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25

require "kate.configs.filetypes"
-- require "kate.configs.tinymist"

require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/kate/snippets/" })
local ls = require("luasnip")
vim.keymap.set("i", "<C-b>", function() ls.expand_or_jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-x>", function() ls.jump(1) end, { silent = true })
-- map({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })


autocmd('LspAttach', {
  group = kateGroup,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>lz", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>lv", "<CMD>LspRestart<CR>", opts)
    vim.keymap.set("n", "<leader>h", "<CMD>Gitsigns preview_hunk<CR>", {})
    vim.keymap.set("n", "<leader>i", "<CMD>Gitsigns preview_hunk_inline<CR>", {})
    vim.keymap.set("i", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>n", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>e", function() vim.diagnostic.goto_prev() end, opts)
  end
})
