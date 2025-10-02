return {
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            doc_lines = 0, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
            -- set to 0 if you DO NOT want any API comments be shown
            -- This setting only take effect in insert mode, it does not affect signature help in normal
            -- mode, 10 by default
            wrap = false,
            fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
            floating_window_above_cur_line = true,
            hint_enable = false, -- virtual hint enable
            hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
            -- -- or, provide a table with 3 icons
            -- hint_prefix = {
            --     above = "↙ ", -- when the hint is on the line above the current line
            --     current = "← ", -- when the hint is on the same line
            --     below = "↖ " -- when the hint is on the line below the current line
            -- },
            handler_opts = {
                border = "single" -- double, rounded, single, shadow, none, or a table of borders
            },
            transparency = nil,   -- disabled by default, allow floating win transparent value 1~100
        },
    }
}
