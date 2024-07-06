-- source the old vimscript
vim.cmd('source ~/.config/nvim/old-init.vim')

-- load the plugins
vim.cmd('source ~/.config/nvim/plugins.vim')
require("globals")
vim.cmd('source ~/.config/nvim/mappings.vim')
vim.cmd('source ~/.config/nvim/plugin-options.vim')
