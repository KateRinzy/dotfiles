---@diagnostic disable: undefined-global
vim.opt.winborder = "single"

vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

local useTabs = false
if useTabs then
    vim.opt.softtabstop = nil
    vim.opt.expandtab = false
else
    vim.opt.softtabstop = 4
    vim.opt.expandtab = true
end

vim.opt.wrap = false
vim.opt.showbreak = "\\-"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
local sidescrolloff = 10
vim.opt.sidescrolloff = sidescrolloff
vim.opt.isfname:append("@-@")

vim.opt.signcolumn = "yes"

vim.opt.foldmethod = "marker"
vim.opt.foldmarker = "{,}"
vim.opt.foldlevelstart = 99

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80


vim.opt.list = true
vim.opt.listchars:append("space:·")
-- vim.opt.listchars:append("space:_")

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.o.cmdheight = 0
vim.api.nvim_create_autocmd({ "CmdlineLeave", "CmdlineChanged", "CmdlineEnter" }, {
    callback = function()
        -- this forces the cmdline to hide after some time
        vim.defer_fn(function()
            if vim.fn.mode() ~= "c" then
                vim.o.cmdheight = 0
            end
        end, 1000)
    end,
})

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
    vim.cmd [[colorscheme kanagawa-lotus]]
    print("Let there be light")
end, {})

vim.api.nvim_create_user_command("Dusk", function()
    vim.opt.background = "dark"
    vim.cmd [[colorscheme gruvbox]]
    print("OHHH, pwetty colours")
end, {})

vim.api.nvim_create_user_command("Rose", function()
    vim.opt.background = "dark"
    vim.cmd [[colorscheme rose-pine-main]]
    print("OHHH, pwetty colours")
end, {})

vim.opt.background = "dark"
vim.cmd [[colorscheme rose-pine-main]]

vim.api.nvim_create_user_command("FocusModeEnable", function()
    vim.opt.list = false
    vim.opt.laststatus = 0
    vim.opt.colorcolumn = ""
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        vim.api.nvim_win_set_option(win, "number", false)
    end
    print("Eepy girl On")
end, {})

vim.api.nvim_create_user_command("FocusModeDisable", function()
    vim.opt.list = true
    vim.opt.laststatus = 2
    vim.opt.colorcolumn = "80"
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

