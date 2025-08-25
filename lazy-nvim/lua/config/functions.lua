-- https://www.imaginaryrobots.net/posts/2021-04-17-converting-vimrc-to-lua/
-- need a map method to handle the different kinds of key maps
function map(mode, combo, mapping, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

function znk_colorscheme()
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
  local zenbone_schemes = util.get_colorscheme_list()

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
end
