-- https://www.imaginaryrobots.net/posts/2021-04-17-converting-vimrc-to-lua/
-- need a map method to handle the different kinds of key maps
function map(mode, combo, mapping, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, combo, mapping, options)
end
