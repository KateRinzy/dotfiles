return {
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                backdrop = 0, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
                width = 120, -- width of the Zen window
                height = 0.8, -- height of the Zen window
                options = {
                    number = false,
                    relativenumber = false, -- disable relative numbers
                    list = false, -- disable whitespace characters
                },
            },
            plugins = {
                tmux = { enabled = false }, -- disables the tmux statusline
            },
            -- callback where you can add custom code when the Zen window opens
            on_open = function(win)
            end,
            -- callback where you can add custom code when the Zen window closes
            on_close = function()
            end,
        }
    }
}
