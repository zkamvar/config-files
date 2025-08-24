-- Configure LazyVim to load dark or light mode scheme
return {
  { "rktjmp/lush.nvim" },
  { "EdenEast/nightfox.nvim" },
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
    "bringsrain/strawberry",
  },
  { -- <https://vimcolorschemes.com/mitch1000/backpack>
    -- NOTE: has a light pink mode, but I haven't seen it
    "mitch1000/backpack",
    config = function()
      vim.g.italicize_comments = 1
      vim.g.backpack_italic = 1
      vim.g.backpack_contrast_dark = "hard" -- soft hard medium
      vim.g.backpack_contrast_light = "hard" -- soft hard medium
    end,
  },
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
  -- {
  --   "f-person/auto-dark-mode.nvim",
  --   opts = {
  --     set_dark_mode = function()
  --       vim.api.nvim_set_option_value("background", "dark", {})
  --       vim.cmd("colorscheme rose-pine-moon")
  --     end,
  --     set_light_mode = function()
  --       vim.api.nvim_set_option_value("background", "light", {})
  --       vim.cmd("colorscheme catppuccin")
  --     end,
  --     update_interval = 3000,
  --     fallback = "light",
  --   },
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local colorschemes = {
          "zenbones",
          "rosebones",
          "tokyobones",
          "zenwritten",
          "neobones",
          -- "tokyonight",
          -- "catppuccin",
        }
        -- stolen from randombones
        if vim.g.colors_name then
          vim.api.nvim_command([[highlight clear]])
        end

        local util = require("zenbones.util")

        math.randomseed(os.time())
        local index = math.random(#colorschemes)
        local colorscheme = colorschemes[index]
        vim.notify(
          "colorscheme: " .. colorscheme,
          "info",
          { title = "plugins/colorscheme.lua" }
        )

        vim.g.colors_name = colorscheme

        util.apply_colorscheme()
      end,
    },
  },
}
