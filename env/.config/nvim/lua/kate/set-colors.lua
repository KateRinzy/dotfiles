---@diagnostic disable: undefined-global

DARK = "dark"
LIGHT = "light"

FIRST = 1
SECOND = 2

local state_file = vim.fn.stdpath("state") .. "/last_theme"

local current_name = nil
local current_variant = nil

local function save_theme(name, variant)
    vim.fn.writefile({ name .. "_" .. tostring(variant) }, state_file)
end

local function load_theme()
    if vim.fn.filereadable(state_file) == 1 then
        local lines = vim.fn.readfile(state_file)
        local saved = lines[1]
        local name, variant_str = saved:match("^(.-)_(%d+)$")
        if name and variant_str then
            local variant = tonumber(variant_str)
            current_name = name
            current_variant = variant
            return name, variant
        end
    end
end

---@class ColorEntry
---@field name string
---@field set_first fun() -- usually the dark variant
---@field set_second? fun() -- usually the light variant

---@type ColorEntry[]
local colorsList = {
    {
        name = "Chrome",
        set_first = function()
            vim.opt.background = DARK
            vim.cmd [[colorscheme monochrome]]

            local fg = "#C4C4C4"
            local bg = "#101010"
            vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "#ff0000" })
            vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = "#000000" })
            vim.api.nvim_set_hl(0, "Comment", { fg = "#333333", bg = "#000000" })
            vim.api.nvim_set_hl(0, "Visual", { fg = bg, bg = fg })
            save_theme("Chrome", FIRST)
            current_name = "Chrome"
            current_variant = FIRST
        end,
        set_second = function()
            vim.opt.background = LIGHT
            vim.cmd [[colorscheme monochrome]]
            vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, fg = "#0E0E0E" })
            save_theme("Chrome", SECOND)
            current_name = "Chrome"
            current_variant = SECOND
        end,
    },
    {
        name = "RoséPine",
        set_first = function()
            require('rose-pine').setup({
                disable_background = true,
            })
            vim.opt.background = DARK
            vim.cmd [[colorscheme rose-pine-main]]

            -- Forcefully enable transparency
            vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
            vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'NONE' })
            vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })

            save_theme("RoséPine", FIRST)
            current_name = "RoséPine"
            current_variant = FIRST
        end,
        set_second = function()
            require('rose-pine').setup({
                disable_background = false,
            })
            vim.opt.background = "light"
            vim.cmd [[colorscheme rose-pine-dawn]]

            -- Forcefully disable transparency
            local p = require('rose-pine.palette')
            vim.api.nvim_set_hl(0, 'Normal', { fg = p.text, bg = p.base })
            vim.api.nvim_set_hl(0, 'NormalNC', { fg = p.subtle, bg = p.base })
            vim.api.nvim_set_hl(0, 'NormalFloat', { fg = p.text, bg = p.overlay })

            save_theme("RoséPine", SECOND)
            current_name = "RoséPine"
            current_variant = SECOND
        end,
    },
    {
        name = "ZenBones",
        set_first = function()
            vim.opt.background = "dark"
            vim.cmd [[colorscheme zenbones]]
            vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2B2725" })
            vim.api.nvim_set_hl(0, "SpellBad", { fg = "#B4BDC3", undercurl = true })
            save_theme("ZenBones", FIRST)
            current_name = "ZenBones"
            current_variant = FIRST
        end,
        set_second = function()
            vim.opt.background = "light"
            vim.cmd [[colorscheme zenbones]]
            vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#E1DCDA" })
            vim.api.nvim_set_hl(0, "SpellBad", { fg = "#2C363C", undercurl = true })
            save_theme("ZenBones", SECOND)
            current_name = "ZenBones"
            current_variant = SECOND
        end,
    },
    {
        name = "Gruvvy",
        set_first = function()
            vim.opt.background = "dark"
            vim.cmd [[colorscheme gruvbox]]
            save_theme("Gruvvy", FIRST)
            current_name = "Gruvvy"
            current_variant = FIRST
        end
    },
    {
        name = "Matrix",
        set_first = function()
            vim.opt.background = "dark"
            vim.cmd [[colorscheme matrix]]
            vim.api.nvim_set_hl(0, "SpellBad", { italic = false, undercurl = true, fg = "#08AE2A" })
            save_theme("Matrix", FIRST)
            current_name = "Matrix"
            current_variant = FIRST
        end,
    },
    {
        name = "BiChromatic",
        set_first = function()
            vim.cmd("highlight clear")
            if vim.fn.exists("syntax_on") == 1 then
                vim.cmd("syntax reset")
            end

            vim.g.colors_name = "bichromatic"

            local bg = "#000000"
            local fg = "#BBBBBB"
            local darkGrey = "#111111"
            local lessGrey = "#222222"
            local tinyGrey = "#777777"

            local function hi(group, opts)
                vim.api.nvim_set_hl(0, group, opts)
            end

            -- Core UI
            hi("Normal", { fg = fg, bg = bg })
            hi("NormalNC", { fg = fg, bg = bg })
            hi("Cursor", { fg = bg, bg = fg })
            hi("CursorLine", { bg = darkGrey })
            hi("CursorColumn", { bg = darkGrey })
            hi("LineNr", { fg = tinyGrey, bg = bg })
            hi("CursorLineNr", { fg = fg, bg = bg, bold = true })
            hi("VertSplit", { fg = fg, bg = bg })
            hi("StatusLine", { fg = fg, bg = bg, bold = true })
            hi("StatusLineNC", { fg = tinyGrey, bg = bg })
            hi("TabLine", { fg = tinyGrey, bg = bg })
            hi("TabLineSel", { fg = fg, bg = bg, bold = true })
            hi("TabLineFill", { fg = fg, bg = bg })

            -- Popup / floating
            hi("Pmenu", { fg = fg, bg = bg })
            hi("PmenuSel", { fg = bg, bg = fg })
            hi("PmenuSbar", { bg = lessGrey })
            hi("PmenuThumb", { bg = fg })

            -- Search / visual
            hi("Search", { fg = bg, bg = fg })
            hi("IncSearch", { fg = bg, bg = fg, bold = true })
            hi("Visual", { bg = lessGrey })

            -- Diagnostics
            hi("Error", { fg = fg, bg = bg, bold = true })
            hi("ErrorMsg", { fg = fg, bg = bg, bold = true })
            hi("WarningMsg", { fg = fg, bg = bg })
            hi("Todo", { fg = bg, bg = fg, bold = true })

            -- Syntax (intentionally flat)
            hi("Comment", { fg = tinyGrey, italic = true })
            hi("Constant", { fg = fg })
            hi("String", { fg = fg })
            hi("Identifier", { fg = fg })
            hi("Function", { fg = fg, bold = true })
            hi("Statement", { fg = fg })
            hi("Keyword", { fg = fg })
            hi("Type", { fg = fg })
            hi("Special", { fg = fg })
            hi("Delimiter", { fg = fg })

            -- Treesitter (optional but common)
            hi("@comment", { link = "Comment" })
            hi("@function", { link = "Function" })
            hi("@keyword", { link = "Keyword" })
            hi("@string", { link = "String" })
            hi("@type", { link = "Type" })
            hi("@variable", { fg = fg })
            save_theme("BiChromatic", FIRST)
            current_name = "BiChromatic"
            current_variant = FIRST
        end,
        set_second = function()
            vim.cmd("highlight clear")
            if vim.fn.exists("syntax_on") == 1 then
                vim.cmd("syntax reset")
            end

            vim.g.colors_name = "bichromatic"

            local bg          = "#faf6f3"
            local fg          = "#000000"
            local lightGrey   = "#eeeeee"
            local lessGrey    = "#dddddd"
            local tinyGrey    = "#777777"

            local function hi(group, opts)
                vim.api.nvim_set_hl(0, group, opts)
            end

            -- Core UI
            hi("Normal", { fg = fg, bg = bg })
            hi("NormalNC", { fg = fg, bg = bg })
            hi("Cursor", { fg = bg, bg = fg })
            hi("CursorLine", { bg = lightGrey })
            hi("CursorColumn", { bg = lightGrey })
            hi("LineNr", { fg = tinyGrey, bg = bg })
            hi("CursorLineNr", { fg = fg, bg = bg, bold = true })
            hi("VertSplit", { fg = fg, bg = bg })
            hi("StatusLine", { fg = fg, bg = bg, bold = true })
            hi("StatusLineNC", { fg = tinyGrey, bg = bg })
            hi("TabLine", { fg = tinyGrey, bg = bg })
            hi("TabLineSel", { fg = fg, bg = bg, bold = true })
            hi("TabLineFill", { fg = fg, bg = bg })

            -- Popup / floating
            hi("Pmenu", { fg = fg, bg = bg })
            hi("PmenuSel", { fg = bg, bg = fg })
            hi("PmenuSbar", { bg = lessGrey })
            hi("PmenuThumb", { bg = fg })

            -- Search / visual
            hi("Search", { fg = bg, bg = fg })
            hi("IncSearch", { fg = bg, bg = fg, bold = true })
            hi("Visual", { bg = lessGrey })

            -- Diagnostics
            hi("Error", { fg = fg, bg = bg, bold = true })
            hi("ErrorMsg", { fg = fg, bg = bg, bold = true })
            hi("WarningMsg", { fg = fg, bg = bg })
            hi("Todo", { fg = bg, bg = fg, bold = true })

            -- Syntax (intentionally flat)
            hi("Comment", { fg = tinyGrey, italic = true })
            hi("Constant", { fg = fg })
            hi("String", { fg = fg })
            hi("Identifier", { fg = fg })
            hi("Function", { fg = fg, bold = true })
            hi("Statement", { fg = fg })
            hi("Keyword", { fg = fg })
            hi("Type", { fg = fg })
            hi("Special", { fg = fg })
            hi("Delimiter", { fg = fg })

            -- Treesitter
            hi("@comment", { link = "Comment" })
            hi("@function", { link = "Function" })
            hi("@keyword", { link = "Keyword" })
            hi("@string", { link = "String" })
            hi("@type", { link = "Type" })
            hi("@variable", { fg = fg })

            save_theme("BiChromatic", SECOND)
            current_name = "BiChromatic"
            current_variant = SECOND
        end
    }
}

local themes = {}
for _, entry in ipairs(colorsList) do
    themes[entry.name .. "_1"] = entry.set_first
    if entry.set_second then
        themes[entry.name .. "_2"] = entry.set_second
    end
end

local name, variant = load_theme()
if name and variant then
    local key = name .. "_" .. variant
    if themes[key] then
        themes[key]()
    end
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

vim.keymap.set("n", "<leader>tl", function()
    if not current_name then return end
    for _, entry in ipairs(colorsList) do
        if entry.name == current_name then
            if entry.set_second then
                if current_variant == FIRST then
                    entry.set_second()
                else
                    entry.set_first()
                end
            end
            break
        end
    end
end, { desc = "Toggle theme variant" })
