---@diagnostic disable: undefined-global
---@diagnostic disable: undefined-field
vim.g.mapleader = " "

vim.g.fzf_layout = { window = { width = 1, height = 0.4, yoffset = 1 } }
vim.g.fzf_preview_window = { 'right:50%' }

vim.cmd([[
  command! -bang FilesNoPDF
    \ call fzf#vim#files(
    \   '',
    \   {
    \     'source': 'rg --files --hidden --no-ignore-vcs --glob "!*.pdf"',
    \     'options': '--preview "bat --style=numbers --color=always --line-range :500 {}"'
    \   },
    \   <bang>0
    \ )
]])

local function l_format()
  local ignored_filetypes = {
    python = true,
    text = true,
    markdown = true,
  }

  local ft = vim.bo.filetype

  if ignored_filetypes[ft] then
    print "Ignored filetype 🥀"
  else
    if next(vim.lsp.get_clients({ bufnr = 0 })) then
      vim.lsp.buf.format()
    end
    print("Bogus Binted? 🤨")
  end
end

local function toggleWrap()
  if vim.o.wrap then
    vim.opt.wrap = false
  else
    vim.opt.wrap = true
  end
end

local function telescope_pdf()
  require('telescope')
  require("telescope.builtin").find_files({
    prompt_title = "Find PDF",
    find_command = { "fd", "--type", "f", "--extension", "pdf" },
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local actions = require("telescope.actions")
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.fn.jobstart({ "zathura", selection.path }, { detach = true })
      end)
      return true
    end,
  })
end

local mappings = {
  { "n",               "<C-t>",      "<cmd>silent !tmux-goway<CR>" },
  { "n",               "<C-y>",      "<cmd>silent !tmux neww yazi-tmux<CR>" },
  { "n",               "<leader>pv", ":NvimTreeToggle<CR>",                    { desc = "Toggle NvimTree" } },
  { "n",               "<ESC>",      "<CMD>noh<CR>" },
  --
  -- { { "n", "v", "x" }, "<M-l>",      "{" },
  -- { { "n", "v", "x" }, "<M-u>",      "}" },
  { { "n", "v" },      "-",          "0" },
  --
  { { "n", "v", "x" }, ";",          ":" },
  { { "n", "v", "x" }, ":",          ";" },
  { { "n", "v" },      "!",          ":!" },
  --
  { { 'n', 'v', 'x' }, 'j',          'gj' },
  { { 'n', 'v', 'x' }, 'k',          'gk' },
  --
  { { "n", "v" },      "<leader>w",  "<ESC>:w<CR>" },
  { "n",               "<leader>pf", ":FilesNoPDF<CR>",                        { desc = "Open fzf (no PDFs)" } },
  --
  { "n",               "<leader>f",  l_format,                                 { desc = "Format the file" } },
  --
  { "n",               "<C-o>",      "<nop>" },
  --
  { "n",               "<leader>k",  ":!make<CR>",                             { desc = "Call make" } },
  --
  { "n",               "<leader>sa", function() vim.cmd([[normal! ggVG]]) end, { desc = "Select the entire file" } },
  --
  { { "n", "v" },      "<leader>3",  "/" },
  --
  { "n",               "<leader>tw", toggleWrap },
  { "n",               "<leader>tm", "<CMD>Markview<CR>" },
  { "n",               "<leader>py", telescope_pdf },

  { "n",               "<leader>x",  "<CMD>!chmod +x %<CR>",                   { silent = true } }
}

for _, value in ipairs(mappings) do
  local mode, keybind, command, options = value[1], value[2], value[3], value[4]

  vim.keymap.set(mode, keybind, command, options)
end
