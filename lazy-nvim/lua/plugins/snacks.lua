return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    -- @type snacks.Config
    opts = {
      gitbrowse = {
        what = "permalink",
      },
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
