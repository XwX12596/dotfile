return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v2.x',
	dependencies = {
		-- LSP Support
		{ 'neovim/nvim-lspconfig' },           -- Required
		{ 'williamboman/mason.nvim' },         -- Optional
		{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

		-- Autocompletion
		{ 'hrsh7th/nvim-cmp' },   -- Required
		{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
		{ 'L3MON4D3/LuaSnip' },   -- Required
	},
	config = function()
		local lsp = require('lsp-zero').preset({
			manage_nvim_cmp = {
				set_extra_mappings = true
			}
		})

		lsp.on_attach(function(client, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			lsp.default_keymaps({ buffer = bufnr })
		end)

		lsp.setup()
		require'lspconfig'.pylsp.setup{
		   settings = {
		     pylsp = {
		       plugins = {
			 pycodestyle = {
			   ignore = {'W391', 'W291', 'E231', 'E226', 'E402'},
			   maxLineLength = 145
			 }
		       }
		     }
		   }
		 }

	end
}
