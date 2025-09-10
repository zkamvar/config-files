-- Configure LazyVim to load dark or light mode scheme
local fun = require("config/functions")

return {
  { "rktjmp/lush.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "talha-akram/noctis.nvim" },
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    -- config = function()
    --     vim.g.zenbones_darken_comments = 45
    --     vim.cmd.colorscheme('zenbones')
    -- end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      day_brightness = 0.4,
    },
  },
  {
    -- NOTE: this is a really pretty pink theme that I like
    "bringsrain/strawberry",
  },
  -- { -- <https://vimcolorschemes.com/mitch1000/backpack>
  --   -- NOTE: this theme throws errors and I may have to abandon it
  --   "mitch1000/backpack",
  --   config = function()
  --     vim.g.italicize_comments = 1
  --     vim.g.backpack_italic = 1
  --     vim.g.backpack_contrast_dark = "medium" -- soft hard medium
  --     vim.g.backpack_contrast_light = "medium" -- soft hard medium
  --   end,
  -- },
  {
    -- TODO: This prevents an issue where catppuccin updated their method for
    -- bufferline and it broke LazyVim. The author of LazyVim is on vacation,
    -- so this is a workaround until they get back.
    -- <https://github.com/LazyVim/LazyVim/pull/6354#issuecomment-3203793593>
    "catppuccin",
    optional = true,
    opts = function()
      local bufferline = require("catppuccin.groups.integrations.bufferline")
      bufferline.get = bufferline.get or bufferline.get_theme
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = set_dark_mode,
      set_light_mode = set_light_mode,
      update_interval = 3000,
      fallback = "light",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = znk_colorscheme,
    },
  },
}
