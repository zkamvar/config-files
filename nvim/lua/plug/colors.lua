-- Airline options
-- ===============================================
vim.g['airline_powerline_fonts'] = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#whitespace#enabled'] = 0
vim.g['airline#extensions#clock#format'] = '%b%d %H:%M'
vim.g['airline#parts#ffenc#skip_expected_string']='utf-8[unix]'
vim.g['airline#extensions#wordcount#formatter#default#fmt'] = 'W:%s'
vim.g['airline#extensions#wordcount#formatter#default#fmt_short'] = 'W:%s'
--
-- Color Scheme Options
-- ===============================================
vim.opt.termguicolors = true -- needed for ayucolor to work
vim.g['indent_guides_start_level'] = 3
vim.g['indent_guides_enable_on_vim_startup'] = 1
vim.g['PaperColor_Theme_Options'] = {
  theme = {
    default = {
      transparent_background = 1,
      allow_bold = 1,
      allow_italic = 1,
    }
  }
}

