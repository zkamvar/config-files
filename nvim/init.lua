-- source the old vimscript
vim.cmd('source ~/.config/nvim/old-init.vim')

-- load the plugins
vim.cmd('source ~/.config/nvim/plugins.vim')
-- vim.cmd('source ~/.config/nvim/mappings.vim')
require("mappings")
vim.cmd('source ~/.config/nvim/plugin-options.vim')
require("plug/colors")
require("plug/treesitter")
require("plug/r-nvim")
require("globals")
