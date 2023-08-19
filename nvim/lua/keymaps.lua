local v = vim
v.g.mapleader = " "
local keymappings = {
	{ config = "n", from = "<leader>rr", to = "<cmd>CellularAutomaton make_it_rain<CR>" },
	{ config = "n", from = "<leader>k",  to = "<C-w><C-w>" },
	{ config = "n", from = "<leader>j",  to = "<cmd>split<CR>" },
	{ config = "n", from = "<leader>l",  to = "<cmd>vsplit<CR>" },
	{ config = "n", from = "<leader>p",  to = "<cmd>BufferLinePick<CR>" },
	{ config = "n", from = "<leader>q",  to = "<cmd>BufferLinePickClose<CR>" },
	{ config = "n", from = "<leader>nh", to = "<cmd>nohl<CR>" },
}

for _, km in ipairs(keymappings) do
	v.keymap.set(km.config, km.from, km.to)
end

-- v.keymap.set("n", "<leader>q", "<cmd>q<CR>")
-- v.keymap.set("n", "H", "5h")
-- v.keymap.set("n", "J", "5j")
-- v.keymap.set("n", "K", "5k")
-- v.keymap.set("n", "L", "5l")

v.api.nvim_set_keymap("n", "<leader>ra", "", {
	noremap = true,
	callback = function()
		require("ranger-nvim").open(true)
	end,
})
