---@diagnostic disable: undefined-global
require "lspconfig"["tinymist"].setup {
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onSave",
        semanticTokens = "enable",
        formatterPrintWidth = 80,
        formatterProseWrap = true
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
}
