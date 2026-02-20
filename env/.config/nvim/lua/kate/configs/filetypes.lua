---@diagnostic disable: undefined-global
---

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "fs", "fsharp" },
  callback = function()
    vim.lsp.handlers["$/progress"] = function() end

    vim.opt.textwidth = 120
    vim.opt.colorcolumn = "120"
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cs", "csharp", "rust" },
  callback = function()
    local width = 4
    vim.o.shiftwidth = width
    vim.o.tabstop = width
    vim.o.softtabstop = width
    vim.o.expandtab = true
    vim.o.colorcolumn = "120"
  end,
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rst" },
  callback = function()
    local width = 2
    vim.o.shiftwidth = width
    vim.o.tabstop = width
    vim.o.softtabstop = width
    vim.o.expandtab = true
    vim.o.colorcolumn = "80"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "h", "cpp", "cc" },
  callback = function()
    local width = 8
    vim.o.shiftwidth = width
    vim.o.tabstop = width
    vim.o.softtabstop = width
    vim.o.expandtab = true
    vim.o.colorcolumn = "80"
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
    vim.opt.spelllang = { "en", "fr", "is", "cjk" }

    vim.opt.textwidth = 80

    vim.opt.wrap = true
    vim.opt.sidescrolloff = 0

    vim.keymap.set("n", "<leader>h", function()
      local file = vim.fn.expand("%:p")
      vim.system({ "typst", "c", file })
    end, { buffer = true, desc = "Compile Typst file" })

    vim.keymap.set("n", "<leader>y", function()
      local pdf = vim.fn.expand("%:p:r") .. ".pdf"
      vim.fn.jobstart({ "zathura", pdf }, { detach = true })
    end, { buffer = true, desc = "Open PDF" })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "txt", "mail" },
  callback = function()
    vim.o.spell = true
    vim.opt.spelllang = { "en", "fr", "is" , "cjk" }

    vim.o.colorcolumn = "80"

    vim.o.wrap = false
    vim.o.sidescrolloff = 0

    local width = 2
    vim.o.shiftwidth = width
    vim.o.tabstop = width
    vim.o.softtabstop = width
    vim.o.expandtab = true

    vim.o.textwidth = 80

    vim.bo.autoindent = false
    vim.bo.smartindent = false
    vim.bo.cindent = false
    vim.bo.indentexpr = ""
    vim.bo.indentkeys = ""
    vim.bo.formatoptions = "t"
    vim.cmd("TSBufDisable indent")
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "md", "markdown" },
  callback = function()
    vim.o.spell = true
    vim.opt.spelllang = { "en", "fr", "cjk" }

    vim.o.colorcolumn = "80"
    vim.o.textwidth = 80

    vim.o.wrap = false
    vim.o.sidescrolloff = 0

    local width = 2
    vim.o.shiftwidth = width
    vim.o.tabstop = width
    vim.o.softtabstop = width
    vim.o.expandtab = true
    vim.keymap.set("n", "<leader>f", function()
      vim.cmd("write")

      local file = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
      vim.cmd("silent !bunx prettier " .. file .. " --write")

      vim.cmd("edit!") -- reload file after formatting
    end, { desc = "Format with Prettier (bunx)" })
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
    local width = 8
    vim.o.shiftwidth = width
    vim.o.tabstop = width
    vim.o.softtabstop = width
    vim.o.expandtab = true

    vim.keymap.set("n", "<leader>h", ":w<CR>:!python3 %<CR>", { buffer = true, desc = "Run Python file" })
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
