---@diagnostic disable: undefined-global
---

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "fs", "fsharp" },
    callback = function()
        vim.lsp.handlers["$/progress"] = function() end
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "h", "cpp", "cc" },
    callback = function()
        local width = 8
        vim.o.shiftwidth = width
        vim.o.tabstop = width
        vim.o.softtabstop = width
        vim.o.expandtab = true
        vim.o.colorcolumn = "120"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "haskell", "hs", "ocaml" },
    callback = function()
        local width = 2
        vim.bo.shiftwidth = width
        vim.bo.tabstop = width
        vim.bo.softtabstop = width
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typst" },
    callback = function()
        vim.opt.spell = true
        vim.opt.spelllang = { "en", "fr", "de", "es", "cjk" }

        vim.opt.textwidth = 80

        vim.opt.wrap = true
        vim.opt.sidescrolloff = 0

        vim.keymap.set("n", "<leader>y", function()
            local pdf = vim.fn.expand("%:p:r") .. ".pdf"
            vim.fn.jobstart({ "zathura", pdf }, { detach = true })
        end, { buffer = true, desc = "Open PDF" })

        vim.keymap.set("n", "<leader>u", function()
            local file = vim.fn.expand("%:p:r") .. ".typ"
            local cmd = { vim.fn.expand("$HOME/Documents/scripts/typst-make"), file }
            vim.fn.jobstart(cmd, {
                stdout_buffered = true,
                stderr_buffered = true,
                on_stdout = function(_, data)
                    if data then print(table.concat(data, "\n")) end
                end,
                on_stderr = function(_, data)
                    if data then print(table.concat(data, "\n")) end
                end,
            })
        end, { buffer = true, desc = "Compile using typst-make" })

        require('telescope')
        vim.keymap.set("n", "<leader>py", function()
            require("telescope.builtin").find_files({
                prompt_title = "Find PDF",
                find_command = { "fd", "--type", "f", "--extension", "pdf" },
                attach_mappings = function(_, map)
                    map("i", "<CR>", function(prompt_bufnr)
                        local action_state = require("telescope.actions.state")
                        local actions = require("telescope.actions")
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        vim.fn.jobstart({ "zathura", selection.path }, { detach = true })
                    end)
                    return true
                end,
            })
        end, {})
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text" },
    callback = function()
        vim.opt.spell = true
        vim.opt.spelllang = { "en", "fr", "de", "es", "cjk" }

        vim.opt.colorcolumn = "80"
        vim.opt.textwidth = 80

        vim.opt.wrap = true
        vim.opt.sidescrolloff = 0
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

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "vue" },
    callback = function()
        vim.opt.colorcolumn = "120"
        vim.opt.indentexpr = ""
        vim.opt.textwidth = 120
    end
})
