vim.g.mapleader = " "
local set = vim.keymap.set

set("n", "<C-t>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
set("n", "<C-y>", "<cmd>silent !tmux neww yazi-tmux<CR>")

set("n", "<leader>pv", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
set("n", "<leader>e", ":NvimTreeFocus<CR>", { desc = "Focus NvimTree" })

set({ "n", "v" }, ";", ":")
set({ "n", "v" }, "!", ":!")

set({ "n" }, "<leader>t", "i<C-R>=strftime('%Y-%m-%d %H:%M:%S')<CR><Esc>",
	{ desc = "Insert the date and time under the cursor" })

set({ "n", "v", "i" }, "<C-w>", "<ESC>:w<CR>")

-- set("i", "<C-u>", "<Esc>")

set("n", "<C-f>", ":Files<CR>", { desc = "Open fzf" })
set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format the file" })

set("n", "<C-m>", ":bnext<CR>")
set("n", "<C-k>", ":bprev<CR>")
set("n", "<C-c>", ":bdelete<CR>")

set("n", "<C-o>", "<nop>")

-- set("n", "<leader>\\", ":ToggleTerm<CR>")

-- set("n", "<leader>mv", ":Markview<CR>")

-- commands related to functions
--
local function removeRN()
	vim.cmd([[%s/\r//g]])
end
local function selectALL()
	vim.cmd([[normal! ggVG]])
end
set("n", "<leader>re", removeRN, { desc = "Remove all \\r" })
set("n", "<leader>sa", selectALL, { desc = "Select the entire file" })

set("n", "<leader>k", ":make<CR>", { desc = "Call make" })


set("n", "<leader>ch", ":e ~/Documents/chat.md<CR>", { desc = "Open chat.md" })

local function toggle_catppuccin_theme()
	if vim.g.catppuccin_flavour == "frappe" then
		vim.g.catppuccin_flavour = "latte"
	else
		vim.g.catppuccin_flavour = "frappe"
	end
	vim.cmd("colorscheme catppuccin")
end

set("n", "<leader>cs", toggle_catppuccin_theme, { desc = "Toggle Catppuccin Theme" })
