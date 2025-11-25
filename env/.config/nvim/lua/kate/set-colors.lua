---@diagnostic disable: undefined-global
---
local state_file = vim.fn.stdpath("state") .. "/last_theme"

local function save_theme(name)
    vim.fn.writefile({ name }, state_file)
end

local function load_theme()
    if vim.fn.filereadable(state_file) == 1 then
        local lines = vim.fn.readfile(state_file)
        return lines[1]
    end
end

local function setMonochrome(background)
    vim.opt.background = background
    vim.cmd [[colorscheme monochrome]]

    if background == "dark" then
        local fg = "#C4C4C4"
        local bg = "#101010"
        vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "#ff0000" })
        vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = "#000000" })
        vim.api.nvim_set_hl(0, "Comment", { fg = "#333333", bg = "#000000" })
        vim.api.nvim_set_hl(0, "Visual", { fg = bg, bg = fg })
    else
        vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, fg = "#85746D" })
    end
end

local themes = {
    MonoDark = function()
        setMonochrome("dark")
        print("Bravo Six, going dark")
        save_theme("MonoDark")
    end,
    MonoLight = function()
        setMonochrome("light")
        print("Let there be light")
        save_theme("MonoLight")
    end,
    Light = function()
        vim.opt.background = "light"
        vim.cmd [[colorscheme rose-pine-dawn]]
        print("Let there be light")
        save_theme("Light")
    end,
    Dusk = function()
        vim.opt.background = "dark"
        vim.cmd [[colorscheme gruvbox]]
        print("OHHH, pwetty colours")
        save_theme("Dusk")
    end,
    Rose = function()
        vim.opt.background = "dark"
        vim.cmd [[colorscheme rose-pine-main]]
        print("OHHH, pwetty colours")
        save_theme("Rose")
    end,
    Matrix = function()
        vim.opt.background = "dark"
        vim.cmd [[colorscheme matrix]]
        vim.api.nvim_set_hl(0, "SpellBad", { italic = true, undercurl = true, fg = "#008F11" })
        print("Hacked in!")
        save_theme("Matrix")
    end,
    Garden = function()
        vim.opt.background = "dark"
        vim.cmd [[colorscheme evergarden-winter]]
        print("Touch grass, you whore")
        save_theme("Garden")
    end,
    Dragons = function()
        vim.opt.background = "dark"
        vim.cmd [[colorscheme kanagawa-dragon]]
        print("Here be dragons")
        save_theme("Dragons")
    end
}

vim.keymap.set("n", "<leader>tl", function()
    if vim.o.background == "dark" then
        setMonochrome("light")
        save_theme("MonoLight")
    else
        setMonochrome("dark")
        save_theme("MonoDark")
    end
    print("hey")
end)

local last = load_theme()
if last and themes[last] then
    themes[last]()
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function pick_theme()
    local keys = vim.tbl_keys(themes)
    table.sort(keys) -- alphabetical order

    pickers.new({}, {
        prompt_title = "Themes",
        finder = finders.new_table {
            results = keys,
        },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            local function run_selection()
                local entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                themes[entry[1]]()
            end
            map("i", "<CR>", run_selection)
            map("n", "<CR>", run_selection)
            return true
        end,
    }):find()
end

vim.keymap.set("n", "<leader>tt", pick_theme, { desc = "Pick theme" })
