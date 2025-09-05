local fun = require("config/functions")
return {
  require("lspconfig").air.setup({
    on_attach = function(_, bufnr)
      -- Only run air format on projects that use air formatting.
      if file_exists("air.toml") then
        vim.notify(
          "this project is auto-formatted with air",
          2, -- 1: DEBUG, 2: INFO
          { title = "formatter" }
        )
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
