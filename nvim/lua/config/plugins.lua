local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- add plugins
plugins = {
    require("config.plugins.autocomplete"),
    require("config.plugins.bufferline"),
    require("config.plugins.comment"),
    require("config.plugins.editor"),
    require("config.plugins.funny"),
    require("config.plugins.git"),
    require("config.plugins.ranger"),
    require("config.plugins.snippets"),
    require("config.plugins.statusline"),
    require("config.plugins.surround"),
    require("config.plugins.treesitter"),
    require("config.plugins.undo"),
    require("config.plugins.window-manager"),
    require("config.plugins.rainbow"),
}
require("lazy").setup(plugins)
