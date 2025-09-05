return {
  require("lspconfig").air.setup({
    on_attach = function(_, bufnr)
      -- Only run air format on projects that use air formatting.
      -- NOTE: I could probably run a detector to see if an air.toml exists
      local fixable_dirs = {
        "getrecast/recast",
        "poppr",
      }
      local current_dir = vim.fn.expand("%:p:h", true)
      local okay_to_fix = false
      for dir in fixable_dirs do
        okay_to_fix = current_dir:match(dir) or okay_to_fix
      end
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
