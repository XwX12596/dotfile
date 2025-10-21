return {
    "keaising/im-select.nvim",
    config = function()
        require('im_select').setup({
      default_im_select = "1033",
    })
    end,
}
