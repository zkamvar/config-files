return {
  require("lspconfig").air.setup({
    on_attach = function(_, bufnr)
      local current_dir = vim.fn.expand("%:p:h", true)
      local okay_to_fix = current_dir:match("getrecast/recast/")
      if okay_to_fix then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end
    end,
  }),
  require("lspconfig").r_language_server.setup({
    on_attach = function(client, _)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  }),
}
