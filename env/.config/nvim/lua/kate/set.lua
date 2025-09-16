---@diagnostic disable: undefined-global
vim.opt.winborder = "single"

vim.opt.nu = true
vim.opt.relativenumber = true

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

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
local sidescrolloff = 10
vim.opt.sidescrolloff = sidescrolloff
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.foldmethod = "marker"
vim.opt.foldmarker = "{,}"
vim.opt.foldlevelstart = 99

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"


vim.opt.list = true
vim.opt.listchars:append("space:·")

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.o.cmdheight = 0

local function toggle_tmux_status()
    local handle = io.popen("tmux show -g status")
    if not handle then return end
    local result = handle:read("*a")
    handle:close()

    if result:match("status on") then
        vim.fn.system("tmux set -g status off")
    else
        vim.fn.system("tmux set -g status on")
    end
end
local function toggle_nvim_status()
    if vim.o.laststatus == 0 then
        vim.o.laststatus = 2
    else
        vim.o.laststatus = 0
    end
end
local function toggle_cml_line()
    if vim.o.cmdheight == 0 then
        vim.o.cmdheight = 1
    else
        vim.o.cmdheight = 0
    end
end
local function toggle_side_scrolloff()
    if vim.o.sidescrolloff == sidescrolloff then
        vim.o.sidescrolloff = 0
    else
        vim.o.sidescrolloff = sidescrolloff
    end
end
local function toggle_list_nu()
    vim.o.list = not vim.o.list
    vim.wo.nu = not vim.wo.nu
    vim.wo.relativenumber = not vim.wo.relativenumber
end

vim.keymap.set("n", "<leader>ts", function()
    -- toggle_tmux_status()
    toggle_nvim_status()
    -- toggle_cml_line()
    toggle_side_scrolloff()
    toggle_list_nu()
end, { desc = "Toggle focus mode" })
