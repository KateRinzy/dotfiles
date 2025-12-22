---@diagnostic disable: undefined-global
vim.opt.winborder = "single"
-- vim.opt.guicursor = ""

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

vim.opt.cursorline = true
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


if vim.g.neovide then
    vim.o.guifont = "Courier Prime Code:h20"
    vim.g.neovide_opacity = 0.8
    vim.g.transparency = 0.8
end
