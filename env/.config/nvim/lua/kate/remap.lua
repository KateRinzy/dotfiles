---@diagnostic disable: undefined-global
---@diagnostic disable: undefined-field
vim.g.mapleader = " "
local set = vim.keymap.set

set("n", "<C-t>", "<cmd>silent !tmux-sessionizer<CR>")
set("n", "<C-y>", "<cmd>silent !tmux neww yazi-tmux<CR>")

set("n", "<leader>pv", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
set("n", "<leader>e", ":NvimTreeFocus<CR>", { desc = "Focus NvimTree" })

set("n", "<ESC>", "<CMD>noh<CR>")

set({ "n", "v", "x" }, ";", ":")
set({ "n", "v", "x" }, ":", ";")
set({ "n", "v" }, "!", ":!")

set('n', '<leader>u', '<Cmd>e #<CR>')
set('n', '<leader>U', '<Cmd>bot sf #<CR>')

set({ 'n', 'v', 'x' }, 'j', 'gj')
set({ 'n', 'v', 'x' }, 'k', 'gk')

set({ "n", "v" }, "<leader>w", "<ESC>:w<CR>")

-- set("i", "<C-u>", "<Esc>")

vim.cmd([[
  command! -bang FilesNoPDF
    \ call fzf#vim#files('', {'source': 'rg --files --hidden --ignore --glob "!*.pdf"'}, <bang>0)
]])
set("n", "<leader>pf", ":FilesNoPDF<CR>", { desc = "Open fzf (no PDFs)" })

set("n", "<leader>f",
    function()
        vim.lsp.buf.format()
        print("Bogus Binted? 🤨")
    end
    , { desc = "Format the file" })

set("n", "<C-o>", "<nop>")

set("n", "<leader>k", ":!make<CR>", { desc = "Call make" })

set("n", "<leader>re", function() vim.cmd([[%s/\r//ge]]) end, { desc = "Remove all \\r" })
set("n", "<leader>sa", function() vim.cmd([[normal! ggVG]]) end, { desc = "Select the entire file" })

set({ "n", "v" }, "<leader>3", "/")

-- https://swnakamura.github.io/posts/vim-japanese-input/
set({ "n", "i" }, "<M-l>", function()
    vim.system({ "fcitx5-remote", "-t" })
end)
