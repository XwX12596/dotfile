vim.g.mapleader = " "
vim.keymap.set("n", "<leader>rr", "<cmd>CellularAutomaton make_it_rain<CR>")
vim.keymap.set("n", "<leader>k", "<C-w><C-w>")
vim.keymap.set("n", "<leader>j", "<cmd>split<CR>")
vim.keymap.set("n", "<leader>l", "<cmd>vsplit<CR>")
vim.keymap.set("n", "<leader>p", "<cmd>BufferLinePick<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>BufferLinePickClose<CR>")
-- vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")
-- vim.keymap.set("n", "H", "5h")
-- vim.keymap.set("n", "J", "5j")
-- vim.keymap.set("n", "K", "5k")
-- vim.keymap.set("n", "L", "5l")

vim.api.nvim_set_keymap("n", "<leader>ra", "", {
      noremap = true,
      callback = function()
        require("ranger-nvim").open(true)
      end,
    })
