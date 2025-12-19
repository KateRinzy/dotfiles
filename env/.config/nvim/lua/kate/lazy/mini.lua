---@diagnostic disable: undefined-global
return {
    {
        'nvim-mini/mini.nvim',
        version = false,
        config = function()
            require('mini.files').setup({
                windows = {
                    -- Whether to show preview of file/directory under cursor
                    preview = true,
                },
            })
            vim.keymap.set("n", "<leader>pl", "<CMD>lua MiniFiles.open()<CR>")
        end
    }
}
