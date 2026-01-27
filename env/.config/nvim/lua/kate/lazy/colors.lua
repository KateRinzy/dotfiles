return {
    { "kdheepak/monochrome.nvim" },
    { "iruzo/matrix-nvim" },
    { "folke/tokyonight.nvim" },
    { "catppuccin/nvim",         name = "catppuccin", priority = 1000 },
    { "rose-pine/neovim",        name = "rose-pine", },
    {
        "zenbones-theme/zenbones.nvim",
        dependencies = "rktjmp/lush.nvim",
        lazy = false,
        priority = 1000,
        -- you can set set configuration options here
        -- config = function()
        --     vim.g.zenbones_darken_comments = 45
        --     vim.cmd.colorscheme('zenbones')
        -- end
    },
    {
        'everviolet/nvim',
        name = 'evergarden',
        opts = {
            theme = {
                variant = 'winter', -- 'winter'|'fall'|'spring'|'summer'
                accent = 'green',
            },
            editor = {
                transparent_background = false,
                sign = { color = 'none' },
                float = {
                    color = 'mantle',
                    solid_border = false,
                },
                completion = {
                    color = 'surface0',
                },
            },
        }
    },
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = false,
                bold = true,
                -- italic = {
                --     strings = false,
                --     emphasis = false,
                --     comments = false,
                --     operators = false,
                --     folds = false,
                -- },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true,    -- invert background for search, diffs, statuslines and errors
                contrast = "soft", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require('kanagawa').setup({
                transparent = false, -- do not set background color
                theme = "wave",      -- Load "wave" theme when 'background' option is not set
                background = {       -- map the value of 'background' option to a theme
                    dark = "wave",   -- try "dragon" !
                    light = "lotus"
                },
            })
        end
    }
}
