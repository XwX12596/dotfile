return {
	{
	    "lewis6991/gitsigns.nvim",
	    config = function()
		require('gitsigns').setup({
		  -- signs = {
		  -- 	add          = { text = '+' },
		  -- 	change       = { text = '│' },
		  -- 	delete       = { text = '_' },
		  -- 	topdelete    = { text = '‾' },
		  -- 	changedelete = { text = '~' },
		  -- 	untracked    = { text = '┆' },
		  -- },
		  signs = {
			  add          = { hl = 'GitSignsAdd', text = '▎', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
			  change       = { hl = 'GitSignsChange', text = '░', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
			  delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
			  topdelete    = { hl = 'GitSignsDelete', text = '▔', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
			  changedelete = { hl = 'GitSignsChange', text = '▒', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
			  untracked    = { hl = 'GitSignsAdd', text = '┆', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
		  },
		})
	    end
	},
	-- {
	-- 	"kdheepak/lazygit.nvim",
	-- 	keys = { "<c-g>" },
	-- 	config = function()
	-- 		vim.g.lazygit_floating_window_scaling_factor = 1.0
	-- 		vim.g.lazygit_floating_window_winblend = 0
	-- 		vim.g.lazygit_use_neovim_remote = true
	-- 		vim.keymap.set("n", "<c-g>", ":LazyGit<CR>", { noremap = true, silent = true })
	-- 	end
	-- },
	-- {
	-- 	"APZelos/blamer.nvim",
	-- 	config = function()
	-- 		vim.g.blamer_enabled = true
	-- 		vim.g.blamer_relative_time = true
	-- 	end
	-- }
}
