require "lspconfig"["tinymist"].setup {
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onType",
        semanticTokens = "enable",
        formatterPrintWidth = 70,
        formatterProseWrap = true
    },
}
