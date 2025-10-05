vim.api.nvim_create_autocmd("FileType", {
    pattern = { "fs", "fsharp" },
    callback = function()
        vim.lsp.handlers["$/progress"] = function() end
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "haskell", "hs", "ocaml", "cpp", "cc" },
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typst" },
    callback = function()
        vim.opt.spell = true
        vim.opt.spelllang = { "en", "fr", "cjk" }

        vim.opt.colorcolumn = "80"
        vim.opt.linebreak = true
        vim.opt.textwidth = 80
        vim.opt.formatoptions:append("t")
        vim.opt.sidescrolloff = 0

        -- keymap to open compiled PDF in zathura
        vim.keymap.set("n", "<leader>y", function()
            local pdf = vim.fn.expand("%:p:r") .. ".pdf"
            vim.fn.jobstart({ "zathura", pdf }, { detach = true })
        end, { buffer = true, desc = "Open PDF in Zathura" })

        vim.keymap.set("n", "<leader>q", function()
            local tw = 70
            vim.bo.textwidth = tw
            local pos = vim.api.nvim_win_get_cursor(0)
            vim.cmd("normal! ggVGgq")
            vim.api.nvim_win_set_cursor(0, pos)
        end, { desc = "Wrap all text to 70 chars" })
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function()
        vim.opt.spell = true
        vim.opt.spelllang = { "en", "fr", "cjk" }

        vim.opt.colorcolumn = "120"
        vim.opt.linebreak = true
        vim.opt.textwidth = 120
        vim.opt.formatoptions:append("t")
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "odin", "go" },
    callback = function()
        -- keep tabs instead of spaces
        vim.opt.softtabstop = nil
        vim.opt.expandtab = false
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python" },
    callback = function()
        vim.opt.foldmethod = "indent"
        vim.opt.foldlevel = 0
    end
})
