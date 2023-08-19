-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
--   config = function ()
--     vim.cmd[[colorscheme tokyonight]]
--     require("tokyonight").setup({
--       style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
--       light_style = "day", -- The theme is used when the background is set to light
--       transparent = vim.g.transparent_enabled, -- Enable this to disable setting the background color
--       terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
--     })
--   end
-- }

return {
  "Mofiqul/dracula.nvim",
  config = function ()
    vim.cmd[[colorscheme dracula]]
  end
}
