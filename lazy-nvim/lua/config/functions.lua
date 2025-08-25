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
    { name = "zenbones" },
    { name = "rosebones" },
    { name = "tokyobones" },
    { name = "zenwritten" },
    { name = "neobones" },
    { name = "tokyonight" },
    { name = "catppuccin" },
    { name = "noctis_lilac", background = "light" },
    -- { name = "noctis_viola", background = "dark" },
    { name = "strawberry-light", background = "light" },
    -- { name = "strawberry-dark", background = "dark" },
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
    "colorscheme: " .. colorscheme.name,
    2, -- 1: DEBUG, 2: INFO
    { title = "plugins/colorscheme.lua" }
  )

  vim.g.colors_name = colorscheme.name

  if colorscheme.background then
    vim.o.background = colorscheme.background
  end

  -- NOTE: This checks if the colorscheme is from zenbones. If it is, then we
  -- should use the zenbones util. If it is not, we should use the vim command
  local is_zenbones, _ = pcall(util.get_colorscheme, colorscheme.name)
  if is_zenbones then
    util.apply_colorscheme()
  else
    vim.cmd("colorscheme " .. colorscheme.name)
  end
end

function get_current_base_theme()
  local theme = vim.g.colors_name or "unset"
  string.gsub(theme, "[-_].*$", "", 1)
end

function switch_variant(alts, background)
  local current, n = get_current_base_theme()
  local colorscheme
  if current == nil then
    return nil
  end
  if n == 0 then
    colorscheme = current
  else
    vim.notify("current : " .. current, 1)
    local variant = alts[current]
    local index = math.random(#variant)
    colorscheme = variant[index]
  end
  vim.api.nvim_set_option_value("background", background, {})
  vim.cmd("colorscheme " .. colorscheme)
end

function set_dark_mode()
  local alts = {
    { noctis = { "noctis_viola" } },
    { strawberry = { "strawberry-dark" } },
  }
  switch_variant(alts, "dark")
end

function set_light_mode()
  local alts = {
    { noctis = { "noctis_lilac" } },
    { strawberry = { "strawberry-light" } },
  }
  switch_variant(alts, "light")
end
