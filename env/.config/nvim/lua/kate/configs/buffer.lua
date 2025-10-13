---@diagnostic disable: undefined-global
---@diagnostic disable: undefined-field

vim.opt.termguicolors = true

local bufferline = require('bufferline')
bufferline.setup {
    options = {
        indicator = {
            style = "underline",
        },
        diagnostics = "nvim_lsp",
        themable = true,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end
    }
}

for i = 1, 9 do
    vim.keymap.set("n", "<A-" .. i .. ">", function()
        bufferline.go_to(i, true) -- (index, focus)
    end, { silent = true, desc = "Go to Bufferline tab " .. i })
end

vim.keymap.set('n', '<A-.>', function()
    vim.cmd [[BufferLineMoveNext]]
end, { desc = 'Move buffer right' })

vim.keymap.set('n', '<A-,>', function()
    vim.cmd [[BufferLineMovePrev]]
end, { desc = 'Move buffer left' })

vim.keymap.set("n", "<C-m>", function ()
    vim.cmd [[BufferLineCycleNext]]
end)
vim.keymap.set("n", "<C-k>", function ()
    vim.cmd [[BufferLineCyclePrev]]
end)
vim.keymap.set("n", "<C-c>", function()
    vim.cmd.bwipeout()
end, { silent = true })
