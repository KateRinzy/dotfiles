---@diagnostic disable: undefined-global
---
vim.lsp.config('*', {
  root_markers = { '.git' },
})

require('cmp')
local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
  "force",
  {},
  vim.lsp.protocol.make_client_capabilities(),
  cmp_lsp.default_capabilities()
)

local lsps = {
  { "html", },
  { "ols",                  {} },
  { "rust_analyzer", },
  { "bashls", },
  { "ts_ls", },
  { "ocamllsp", },
  { "pyright", },
  { "cssls", },
  { "lua_ls", },
  { "hls",                  {} },
  { "csharp_ls", },
  { "fsautocomplete", },
  { "lemminx", },
  { "zls", },
  { "java_language_server", },
  { "clangd", },
  {
    "gopls",
    { filetypes = { "go", "gomod" } }
  },
  {
    "tinymist",
    {
      capabilities = capabilities,
      settings = {
        formatterMode = "typstyle",
        exportPdf = "never",
        semanticTokens = "enable",
        formatterPrintWidth = 80,
        formatterProseWrap = true,
      },
    },
  },
}

for _, lsp in ipairs(lsps) do
  local name, config = lsp[1], lsp[2]
  vim.lsp.enable(name)
  if config ~= nil then
    vim.lsp.config(name, config)
  end
end
