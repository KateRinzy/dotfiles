---@diagnostic disable: undefined-global
---@diagnostic disable: undefined-field
vim.g.mapleader = " "

vim.g.fzf_layout = { window = { width = 1, height = 0.4, yoffset = 1 } }
vim.g.fzf_preview_window = { 'right:50%' }

vim.cmd([[
  command! -bang FilesNoPDF
    \ call fzf#vim#files(
    \   '',
    \   {
    \     'source': 'rg --files --hidden --no-ignore-vcs --glob "!*.pdf"',
    \     'options': '--preview "bat --style=numbers --color=always --line-range :500 {}"'
    \   },
    \   <bang>0
    \ )
]])

local mappings = {
    { "n",               "<C-t>",      "<cmd>silent !tmux-goway<CR>" },
    { "n",               "<C-y>",      "<cmd>silent !tmux neww yazi-tmux<CR>" },
    { "n",               "<leader>pv", ":NvimTreeToggle<CR>",                 { desc = "Toggle NvimTree" } },
    { "n",               "<leader>e",  ":NvimTreeFocus<CR>",                  { desc = "Focus NvimTree" } },
    { "n",               "<ESC>",      "<CMD>noh<CR>" },
    --
    { { "n", "v", "x" }, "<M-l>",      "{" },
    { { "n", "v", "x" }, "<M-u>",      "}" },
    --
    { { "n", "v", "x" }, ";",          ":" },
    { { "n", "v", "x" }, ":",          ";" },
    { { "n", "v" },      "!",          ":!" },
    --
    { 'n',               '<leader>u',  '<Cmd>e #<CR>' },
    { 'n',               '<leader>U',  '<Cmd>bot sf #<CR>' },
    --
    { { 'n', 'v', 'x' }, 'j',          'gj' },
    { { 'n', 'v', 'x' }, 'k',          'gk' },
    --
    { { "n", "v" },      "<leader>w",  "<ESC>:w<CR>" },
    { "n",               "<leader>pf", ":FilesNoPDF<CR>",                     { desc = "Open fzf (no PDFs)" } },
    --
    { "n", "<leader>f", function()
        vim.lsp.buf.format()
        print("Bogus Binted? 🤨")
    end, { desc = "Format the file" } },
    --
    { "n",          "<C-o>",      "<nop>" },
    --
    { "n",          "<leader>k",  ":!make<CR>",                             { desc = "Call make" } },
    --
    { "n",          "<leader>re", function() vim.cmd([[%s/\r//ge]]) end,    { desc = "Remove all \\r" } },
    { "n",          "<leader>sa", function() vim.cmd([[normal! ggVG]]) end, { desc = "Select the entire file" } },
    --
    { { "n", "v" }, "<leader>3",  "/" },
}

for _, value in ipairs(mappings) do
    local mode, keybind, command, options = value[1], value[2], value[3], value[4]

    vim.keymap.set(mode, keybind, command, options)
end
