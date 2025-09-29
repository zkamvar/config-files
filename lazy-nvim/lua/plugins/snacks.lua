return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = {
        sources = {
          notifications = {
            win = {
              wo = {
                wrap = true,
              },
            },
          },
        },
      },
    },
  },
}
