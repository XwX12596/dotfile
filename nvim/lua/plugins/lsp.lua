require("mason").setup({
  ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
  }
})

require("mason-lspconfig").setup({
  -- 确保安装，根据需要填写
  ensure_installed = {
    "lua_ls",
    "pylsp",
    "texlab",
    "yamlls",
    "clangd",
    "ltex",
  },
})


require("lspconfig").lua_ls.setup {}
require("lspconfig").pylsp.setup {}
require("lspconfig").texlab.setup {}
require("lspconfig").yamlls.setup {}
require("lspconfig").clangd.setup {}
require("lspconfig").ltex.setup {}
