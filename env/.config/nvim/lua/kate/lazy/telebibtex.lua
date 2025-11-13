return {
    {
        "nvim-telescope/telescope-bibtex.nvim",
        requires = {
            { 'nvim-telescope/telescope.nvim' },
        },
        config = function()
            require "telescope".load_extension("bibtex")

            vim.keymap.set("n", "<leader>pb", "<CMD>Telescope bibtex<CR>")
        end,
    }
}
