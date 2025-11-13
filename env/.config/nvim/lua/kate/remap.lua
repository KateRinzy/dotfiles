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

set({'n', 'v', 'x'}, 'j', 'gj')
set({'n', 'v', 'x'}, 'k', 'gk')

set({ "n", "v" }, "<leader>w", "<ESC>:w<CR>")

-- set("i", "<C-u>", "<Esc>")

set("n", "<leader>pf", ":Files<CR>", { desc = "Open fzf" })
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

vim.api.nvim_create_user_command("FocusModeEnable", function()
    vim.opt.list = false
    vim.opt.laststatus = 0
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        vim.api.nvim_win_set_option(win, "number", false)
    end
    print("Eepy girl On")
end, {})

vim.api.nvim_create_user_command("FocusModeDisable", function()
    vim.opt.list = true
    vim.opt.laststatus = 2
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        vim.api.nvim_win_set_option(win, "number", true)
    end
    print("Eepy girl Off")
end, {})

vim.api.nvim_create_user_command("ToggleCmp", function()
    vim.keymap.set("n", "<leader>tc", function()
        _G.cmp_enabled = not _G.cmp_enabled
        print("nvim-cmp " .. (_G.cmp_enabled and "enabled" or "disabled"))
    end, { desc = "Toggle nvim-cmp" })
end, {})

vim.api.nvim_create_user_command("InsertTime", function()
    local datetime = os.date("%Y-%m-%d %H:%M:%S")
    vim.api.nvim_put({ datetime }, "c", true, true)
end, {})

vim.api.nvim_create_user_command("Dark", function()
    vim.opt.background = "dark"
    vim.cmd [[colorscheme monochrome]]
    local fg = "#777777"
    local bg = "#101010"
    vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "#ff0000" })
    vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = "#000000" })
    vim.api.nvim_set_hl(0, "Comment", { fg = "#333333", bg = "#000000" })
    vim.api.nvim_set_hl(0, "Visual", { fg = bg, bg = fg })
    print("Bravo Six, going dark")
end, {})

vim.api.nvim_create_user_command("Light", function()
    vim.opt.background = "light"
    vim.cmd [[colorscheme rose-pine-dawn]]
    print("Let there be light")
end, {})

vim.api.nvim_create_user_command("Dusk", function()
    vim.opt.background = "dark"
    vim.cmd [[colorscheme rose-pine-main]]
    print("OHHH, pwetty colours")
end, {})

set({ "n", "v" }, "<leader>3", "/")

-- https://swnakamura.github.io/posts/vim-japanese-input/
set({ "n", "i" }, "<M-l>", function()
    vim.system({ "fcitx5-remote", "-t" })
end)
