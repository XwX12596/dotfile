local v = vim
local lazypath = v.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not v.loop.fs_stat(lazypath) then
	v.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
v.opt.rtp:prepend(lazypath)

-- add plugins
local plugins = {
	require("plugins.colorscheme"),
	require("plugins.transparent"),
	require("plugins.autocomplete"),
	require("plugins.bufferline"),
	require("plugins.comment"),
	require("plugins.editor"),
	require("plugins.funny"),
	require("plugins.git"),
	require("plugins.ranger"),
	require("plugins.snippets"),
	require("plugins.statusline"),
	require("plugins.surround"),
	require("plugins.treesitter"),
	require("plugins.undo"),
	require("plugins.window-manager"),
	require("plugins.rainbow"),
	require("plugins.multi-cursor"),
	require("plugins.lsp"),
}
require("lazy").setup(plugins)

-- neovide
if v.g.neovide then
	v.o.guifont = "Hack:h14" -- text below applies for VimScript
	v.g.neovide_transparency = 0.8
	-- v.g.neovide_fullscreen = true
end
