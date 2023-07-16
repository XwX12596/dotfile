vim.g.mapleader = " "

local keymap = vim.keymap

-- ---------- 正常模式 ---------- ---
-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口 
keymap.set("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- 窗口
keymap.set("n", "<leader>j", ":split<CR>")
keymap.set("n", "<leader>l", ":vsplit<CR>")
keymap.set("n", "<leader>q", ":q<CR>")

-- 切换buffer
keymap.set("n", "<C-L>", ":bnext<CR>")
keymap.set("n", "<C-H>", ":bprevious<CR>")

-- ---------- 插件 ---------- ---
-- nvim-tree
keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>")
