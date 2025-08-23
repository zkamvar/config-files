-- Configure LazyVim to load dark or light mode scheme
return {
  { "rktjmp/lush.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "talha-akram/noctis.nvim" },
  -- {
  --   "f-person/auto-dark-mode.nvim",
  --   opts = {
  --     set_dark_mode = function()
  --       vim.api.nvim_set_option_value("background", "dark", {})
  --       vim.cmd("colorscheme rose-pine-moon")
  --     end,
  --     set_light_mode = function()
  --       vim.api.nvim_set_option_value("background", "light", {})
  --       vim.cmd("colorscheme catppuccin-latte")
  --     end,
  --     update_interval = 3000,
  --     fallback = "light",
  --   },
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
