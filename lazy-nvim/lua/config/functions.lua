-- https://www.imaginaryrobots.net/posts/2021-04-17-converting-vimrc-to-lua/
-- need a map method to handle the different kinds of key maps
function map(mode, combo, mapping, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

-- Choose between random selection of good colorschemes
--
-- @param type one of "dark" or "light" (defaults to "light")
--
-- This function will choose one of a pre-selected set of colorschemes at
-- random and apply it. This builds off of the "randombones" colorscheme, but
-- makes it safe for the current theme.
function znk_colorscheme(type, verbose)
  verbose = verbose or false
  type = type or "light"
  -- themes that auto-switch between dark and light mode
  local hybrid = {
    { name = "zenbones" },
    { name = "rosebones" },
    { name = "forestbones" },
    { name = "tokyobones" },
    { name = "zenwritten" },
    { name = "neobones" },
    { name = "tokyonight" },
    { name = "catppuccin" },
    { name = "rose-pine" },
  }

  -- themes that are specifically dark OR light
  local themes = {
    dark = {
      { name = "noctis_viola", background = "dark" },
      { name = "noctis_bordo", background = "dark" },
      { name = "noctis_obscuro", background = "dark" },
      { name = "noctis_uva", background = "dark" },
      { name = "strawberry-dark", background = "dark" },
      { name = "duckbones", background = "dark" },
    },
    light = {
      -- { name = "backpack", background = "light" },
      { name = "noctis_hibernus", background = "light" },
      { name = "noctis_lilac", background = "light" },
      { name = "noctis_lux", background = "light" },
      { name = "strawberry-light", background = "light" },
    },
  }
  -- depending on the choice, loop through the bg-specific themes and add them
  -- to the table.
  local colorschemes = hybrid
  for _, v in ipairs(themes[type]) do
    table.insert(colorschemes, v)
  end

  -- stolen from randombones
  if vim.g.colors_name then
    vim.api.nvim_command([[highlight clear]])
  end

  local util = require("zenbones.util")

  math.randomseed(os.time())
  local index = math.random(#colorschemes)
  local colorscheme = colorschemes[index]
  if verbose then
    vim.notify(
      "colorscheme: " .. colorscheme.name,
      2, -- 1: DEBUG, 2: INFO
      { title = "plugins/colorscheme.lua" }
    )
  end

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
  return string.gsub(theme, "[-_].*$", "", 1)
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
  znk_colorscheme("dark", true)
  vim.api.nvim_set_option_value("background", "dark", {})
end

function set_light_mode()
  znk_colorscheme("light", true)
  vim.api.nvim_set_option_value("background", "light", {})
end

function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end
