-- source the old vimscript
vim.cmd('source ~/.config/nvim/old-init.vim')

-- load the plugins
vim.cmd('source ~/.config/nvim/plugins.vim')
require("globals")
-- vim.cmd('source ~/.config/nvim/mappings.vim')
require("mappings")
vim.cmd('source ~/.config/nvim/plugin-options.vim')
require("plug/colors")
require("plug/treesitter")
require("plug/r-nvim")
require("lspconfig").air.setup({
    on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end,
})
