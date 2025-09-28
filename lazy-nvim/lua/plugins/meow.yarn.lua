return {
  {
    "retran/meow.yarn.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("meow.yarn").setup({})
    end,
  },
}
