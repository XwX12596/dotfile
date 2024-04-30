local v = vim
v.g.mapleader = " "
local keymappings = {
	{ config = "n", from = "<leader>rr", to = "<cmd>CellularAutomaton make_it_rain<CR>" },
	{ config = "n", from = "<leader>k",  to = "<C-w><C-w>" },
	{ config = "n", from = "<leader>p",  to = "<cmd>BufferLinePick<CR>" },
	{ config = "n", from = "<leader>q",  to = "<cmd>BufferLinePickClose<CR>" },
	{ config = "n", from = "<leader>nh", to = "<cmd>nohl<CR>" },
	{ config = "n", from = "<leader>lsp", to = "<cmd>LspStop<CR>" },
	{ config = "n", from = "<F5>", to = function()
	  require('dap').continue()
	  v.fn.execute(":w")
	  end },
	{ config = "n", from = "<F6>", to = function() require('dap').close() end },
	{ config = "n", from = "<F7>", to = "<cmd>w<CR><cmd>!!<CR><CR>"},
	{ config = "n", from = "<F9>", to = function() require('dap').step_over() end },
	{ config = "n", from = "<F10>", to = function() require('dap').step_into() end },
	{ config = "n", from = "<F11>", to = function() require('dap').step_out() end },
	{ config = "n", from = "<leader>b", to = function() require('dap').toggle_breakpoint() end },
	{ config = "n", from = "<leader>lp", to = function() require('dap').set_breakpoint(nil, nil, v.fn.input('Log point message: ')) end },
	{ config = "n", from = "<leader>dr", to = function() require('dap').repl.open() end },
	{ config = {"n", "v"}, from = "<leader>dh", to = function() require('dap.ui.widgets').hover() end },
	{ config = {"n", "v"}, from = "<2-LeftMouse>", to = function() require('dap.ui.widgets').hover() end },
	{ config = {"n", "v"}, from = "<leader>dp", to = function() require('dap.ui.widgets').preview() end },
	{ config = "n", from = "<leader>df", to = function()
	  local widgets = require('dap.ui.widgets')
	  widgets.centered_float(widgets.frames)
	  end },
	{ config = "n", from = "<leader>ds", to = function()
	  local widgets = require('dap.ui.widgets')
	  widgets.centered_float(widgets.scopes)
	  end },
	{ config = {"n"}, from = "<leader>ll", to = "<cmd>w<CR><leader>ll"},
}

for _, km in ipairs(keymappings) do
	v.keymap.set(km.config, km.from, km.to)
end

-- v.keymap.set("n", "<leader>q", "<cmd>q<CR>")
-- v.keymap.set("n", "H", "5h")
-- v.keymap.set("n", "J", "5j")
-- v.keymap.set("n", "K", "5k")
-- v.keymap.set("n", "L", "5l")
-- { config = "n", from = "<leader>j",  to = "<cmd>split<CR>" },
-- { config = "n", from = "<leader>l",  to = "<cmd>vsplit<CR>" },

v.api.nvim_set_keymap("n", "<leader>ran", "", {
	noremap = true,
	callback = function()
		require("ranger-nvim").open(true)
	end,
})
