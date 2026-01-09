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
    { "basedpyright", },
    { "ts_ls", },
    { "ocamllsp", },
    { "basedpyright", },
    { "cssls", },
    { "lua_ls", },
    { "hls",                  {} },
    { "csharp_ls", },
    { "fsautocomplete", },
    { "lemminx", },
    { "zls", },
    { "java_language_server", },
    {
        "clangd",
        { init_options = { fallbackFlags = { "--std=c23" }, }, },
    },
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
            on_attach = function(client, bufnr)
                vim.keymap.set("n", "<leader>tp", function()
                    client:exec_cmd({
                        title = "pin",
                        command = "tinymist.pinMain",
                        arguments = { vim.api.nvim_buf_get_name(0) },
                    }, { bufnr = bufnr })
                end, { desc = "[T]inymist [P]in", noremap = true })

                vim.keymap.set("n", "<leader>tu", function()
                    client:exec_cmd({
                        title = "unpin",
                        command = "tinymist.pinMain",
                        arguments = { vim.v.null },
                    }, { bufnr = bufnr })
                end, { desc = "[T]inymist [U]npin", noremap = true })
            end,
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
